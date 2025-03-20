# pod组件更新脚本


pod lib lint --no-clean --allow-warnings



pod trunk push YYRouter.podspec --allow-warnings


### 出现这个错误时：
[!] Authentication token is invalid or unverified. Either verify it with the email that was sent or register a new session.
### 解决方法：
pod trunk register your_email@example.com 'Your Name'
