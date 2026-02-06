# Repository Guidelines

## Project Structure & Ownership
- `lib/`: Flutter 业务代码主目录（后续开发唯一入口）。
- `android/`, `ios/`: 原生工程与打包配置。
- `test/`: 自动化测试（单元测试、Widget 测试）。
- `scripts/`: 初始化、卸载、符号导出等脚本。
- `.claude/`, `.vscode/`: 工具配置目录，仅存放协作/编辑器配置。
- `build/`, `.dart_tool/`, `ios/Pods/`, `ios/.symlinks/`: 构建产物或依赖缓存，禁止放业务代码。

## `lib/` Folder Responsibilities (Current Structure)
- `lib/main.dart`: 应用启动、全局初始化、`MaterialApp` 装配。
- `lib/pages/`: 页面级 UI（路由页面、页面内交互）。
- `lib/components/`: 跨页面复用组件（如网络图片、加载组件）。
- `lib/core/network/`: `Dio` 客户端、鉴权拦截器、日志拦截器。
- `lib/core/repos/`: 数据仓库层（封装 API 访问，如 `health_repo.dart`）。
- `lib/core/blocs/`: 状态管理与错误处理（`Cubit/Bloc`、状态类、扩展）。
- `lib/core/store/`: 全局配置状态（主题、语言）与 Provider 注入。
- `lib/i18n/`: 国际化代理、语言资源、文案定义。
- `lib/utils/`: 通用工具（本地存储、弹窗、Toast、公共方法）。
- `lib/constants.dart`, `lib/enums.dart`, `lib/theme.dart`: 全局常量、枚举、主题。

## Strict Placement Rules (Must Follow)
- 新需求先判断归属，再创建代码；禁止“先写到页面里再挪”。
- 页面逻辑放 `lib/pages/`；可复用 UI 必须抽到 `lib/components/`。
- API 调用必须经过 `lib/core/repos/` + `lib/core/network/`，不要在页面直接发请求。
- 状态流转放 `lib/core/blocs/`；全局配置放 `lib/core/store/`。
- 持久化、弹窗、Toast、通用校验放 `lib/utils/`。
- 文案变更必须同步 `lib/i18n/` 多语言文件。
- 新增目录需与现有分层一致；若超出分层，先在 PR 说明架构理由。

## Requirement-to-Folder Mapping
- 新增页面/路由：`lib/pages/`。
- 新增通用组件（2 个及以上页面复用）：`lib/components/`。
- 新增接口调用或请求封装：`lib/core/repos/`（调用） + `lib/core/network/`（底层能力）。
- 新增页面状态机、异步状态、错误态：`lib/core/blocs/`。
- 新增全局设置项（语言/主题/偏好）：`lib/core/store/` + `lib/utils/sp_util.dart`。
- 新增全局常量/枚举：`lib/constants.dart` 或 `lib/enums.dart`。
- 新增多语言文案：`lib/i18n/i18n.dart` 与对应 `lib/i18n/i18n_*.dart`。
- 新增纯工具方法：`lib/utils/`。

## Build, Test, and Development Commands
- `flutter pub get`: 安装依赖。
- `flutter run`: 本地运行。
- `flutter analyze`: 静态检查。
- `flutter test`: 执行测试。
- `./scripts/init.sh`: 初始化项目名、包名、显示名。

## Code Style, Testing, and PR Rules
- 遵循 `analysis_options.yaml` + `flutter_lints`，提交前执行 `dart format lib test`。
- 命名：文件 `snake_case.dart`，类 `PascalCase`，变量/方法 `camelCase`。
- Commit 建议继续使用 Conventional Commits（如 `feat:`, `refactor(scope):`, `chore:`）。
- PR 必须包含：变更目的、影响目录、测试结果（`flutter analyze`/`flutter test`），UI 变更附截图。
