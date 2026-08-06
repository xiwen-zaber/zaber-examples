assert(ispc, "compiler.build.standaloneWindowsApplication is only supported on Windows.");

projectRoot = fileparts(mfilename('fullpath'));

% Create target build options object, set build properties and build.
buildOpts = compiler.build.StandaloneApplicationOptions(fullfile(projectRoot, "src", "desktop_app.m"));
buildOpts.AdditionalFiles = [zaber.motion.Helper.getCompilerDependencies(), ...
    fullfile(projectRoot, "img", "zaber_logo.png"), ...
    fullfile(projectRoot, "img", "app_icon.png")];
buildOpts.OutputDir = fullfile(projectRoot, "ZaberDesktopApp", "output", "build");
buildOpts.Verbose = true;
buildOpts.ExecutableName = "ZaberDesktopApp";
buildOpts.ExecutableVersion = "1.0.0";
buildOpts.ExecutableIcon = fullfile(projectRoot, "img", "app_icon.png");
buildOpts.ExecutableSplashScreen = fullfile(projectRoot, "img", "splash_screen.png");

buildResults = compiler.build.standaloneWindowsApplication(buildOpts);

% Create an installer for the app.
installerOpts = compiler.package.InstallerOptions(buildResults);
installerOpts.ApplicationName = "Zaber Desktop App";
installerOpts.AuthorCompany = "Zaber Technologies Inc.";
installerOpts.InstallerName = "ZaberDesktopAppInstaller";
installerOpts.Version = "1.0.0";
installerOpts.OutputDir = fullfile(projectRoot, "ZaberDesktopApp", "output", "installer");
installerOpts.InstallerIcon = fullfile(projectRoot, "img", "app_icon.png");
installerOpts.InstallerSplash = fullfile(projectRoot, "img", "splash_screen.png");
% RuntimeDelivery="web" keeps the installer small by downloading the MATLAB Runtime
% during installation; use "installer" to embed the runtime instead.
installerOpts.RuntimeDelivery = "web";

compiler.package.installer(buildResults, Options=installerOpts);
