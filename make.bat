SET BIN=%CD%\bin
SET PATH=%BIN%;%PATH%

del /F /Q packages\* windows_app_lifecycle.tgz
nuget restore || exit /b 1
devenv WindowsCircus.sln /build "Release" || exit /b 1
packages\nspec.0.9.68\tools\NSpecRunner.exe Builder.Tests\bin\Release\BuilderTests.dll || exit /b 1
packages\nspec.0.9.68\tools\NSpecRunner.exe Launcher.Tests\bin\Release\LauncherTests.dll || exit /b 1
packages\nspec.0.9.68\tools\NSpecRunner.exe WebAppServer.Tests\bin\Release\WebAppServer.Tests.dll || exit /b 1
bsdtar -czvf windows_app_lifecycle.tgz --exclude log -C Builder\bin . -C ..\..\Launcher\bin . -C ..\..\Healthcheck\bin . -C ..\..\WebAppServer\bin . || exit /b 1