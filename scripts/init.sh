#!/usr/bin/env bash
set -euo pipefail

# 执行这个脚本对项目进行初始化配置

# 询问用户项目名称，只能有小写字母和数字，不能有特殊字符
echo "1. 请输入项目名，主要用于生成包名，建议使用小写字母和数字："
read project_name
if [ -z "$project_name" ]; then
  echo "项目名不能为空"
  exit 1
fi
if [[ $project_name =~ [^a-z0-9] ]]; then
  echo "项目名只能包含小写字母和数字"
  exit 1
fi

# 询问要使用的域名
echo "2. 请输入域名："
read domain

# 询问项目的显示名称
echo "3. 请输入项目的显示名称："
read app_name

# 处理不同系统的 sed -i 语法
if sed --version >/dev/null 2>&1; then
  SED_INPLACE=(-i)
else
  SED_INPLACE=(-i '')
fi

# 生成自定义包名，将域名反转（比如: domain 是 example.com, project_name 为 demo, 则包名为 com.example.demo）
domain_clean=$(echo "$domain" | sed -E 's#^[a-zA-Z]+://##; s#/.*$##; s#:.*$##' | tr '[:upper:]' '[:lower:]')
if [ -z "$domain_clean" ]; then
  echo "域名不能为空"
  exit 1
fi

IFS='.' read -ra domain_parts <<< "$domain_clean"
package_prefix=""
for ((i=${#domain_parts[@]}-1; i>=0; i--)); do
  segment=$(echo "${domain_parts[i]}" | tr -cd '[:alnum:]')
  if [ -n "$segment" ]; then
    if [ -z "$package_prefix" ]; then
      package_prefix=$segment
    else
      package_prefix="$package_prefix.$segment"
    fi
  fi
done

if [ -z "$package_prefix" ]; then
  echo "域名格式不正确，无法生成包名前缀"
  exit 1
fi

package_name="$package_prefix.$project_name"
echo "生成的包名为：$package_name"

echo "开始初始化项目..."

# 将 android/fastlane/Appfile 中的 com.example.flutter_project_template 改为包名
sed "${SED_INPLACE[@]}" "s/com.example.flutter_project_template/$package_name/g" android/fastlane/Appfile

# 将 pubspec.yaml 中的 flutter_project_template 替换为项目名
sed "${SED_INPLACE[@]}" "s/flutter_project_template/$project_name/g" pubspec.yaml

# 将 test/widget_test.dart 中的 flutter_project_template 替换为项目名
sed "${SED_INPLACE[@]}" "s/flutter_project_template/$project_name/g" test/widget_test.dart

# 将 README.md 中的 flutter_project_template 替换为项目名
sed "${SED_INPLACE[@]}" "s/flutter_project_template/$app_name/g" README.md

# 将 lib 文件夹下的所有文件里的 flutter_project_template 替换为项目名
find lib -name "*.dart" -exec sed "${SED_INPLACE[@]}" "s/flutter_project_template/$project_name/g" {} +

# 格式化 lib 文件夹下的所有文件
dart format lib

# 格式化 test 文件夹下的所有文件
dart format test

# 修改Android包名
sed "${SED_INPLACE[@]}" "s/com.example.flutter_project_template/$package_name/g" android/app/build.gradle.kts
old_main="android/app/src/main/kotlin/com/example/flutter_project_template/MainActivity.kt"
sed "${SED_INPLACE[@]}" "s/com.example.flutter_project_template/$package_name/g" "$old_main"

# 修改 MainActivity.kt 的文件路径
kotlin_root="android/app/src/main/kotlin"
package_dir=${package_name//./\/}
new_main_dir="$kotlin_root/$package_dir"
mkdir -p "$new_main_dir"
mv "$old_main" "$new_main_dir/MainActivity.kt"
find "$kotlin_root" -type d -empty -delete

# 5. 修改Android 程序名 android:label
sed "${SED_INPLACE[@]}" "s/flutter_project_template/$app_name/g" android/app/src/main/AndroidManifest.xml

# 6. iOS 包名 `PRODUCT_BUNDLE_IDENTIFIER`
sed "${SED_INPLACE[@]}" "s/com.example.flutterProjectTemplate/$package_name/g" ios/Runner.xcodeproj/project.pbxproj

# 修改 iOS 程序名称 `CFBundleDisplayName`
sed "${SED_INPLACE[@]}" "s/Flutter Project Template/$app_name/g" ios/Runner/Info.plist

# 将 ios/Runner/Info.plist 中的 "flutter_project_template" 改为 project_name
sed "${SED_INPLACE[@]}" "s/flutter_project_template/$project_name/g" ios/Runner/Info.plist


echo "🎉 初始化完成"
echo "⚠️ 请执行以下命令，解决代码错误:"
echo "flutter pub get"