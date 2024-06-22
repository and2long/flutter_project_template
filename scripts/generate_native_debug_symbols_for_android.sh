project_dir=$(pwd)
t_file="native_debug_symbols.zip"

cd build/app/intermediates/merged_native_libs/release/out/lib/ || exit
zip -r $t_file arm64-v8a
mv $t_file "$project_dir"