$InstallerPath = 'W:\Scripts\Toby\pkgps\installers'

If (!(Test-Path -Path $InstallerPath -PathType Container)) {
    New-Item -Path $InstallerPath -ItemType Directory | Out-Null
}

$ChromeUrl = "http://dl.google.com/chrome/install"
$ChromeVersion = "375.126/chrome_installer.exe"
$ReaderUrl = "http://ardownload.adobe.com/pub/adobe/reader/win/AcrobatDC"
$ReaderVersion = "1801120035/AcroRdrDC1801120035_en_US.exe"
$VlcUrl = "https://get.videolan.org/vlc"
$VlcVersion = "3.0.0/win64/vlc-3.0.0-win64.exe"

$Packages = @(
    @{
	Title		= 'Chrome'
	Url		= "$ChromeUrl/$ChromeVersion"
	Arguments	= ' /silent /install'
	Destination	= $InstallerPath
    },
    @{
	Title		= 'Reader'
	Url		= "$ReaderUrl/$ReaderVersion"
	Arguments	= ' /msi EULA_ACCEPT=YES /qn /quiet'
	Destination	= $InstallerPath
    },
    @{
	Title		= 'VLC'
	Url		= "$VlcUrl/$VlcVersion"
	Arguments	= ' /L=1033 /S'
	Destination	= $InstallerPath
    }
)

Write-Host -fore Yellow "`nDownloading Packages ..."

foreach ($package in $packages) {
    $packageName = $package.Title
    $fileName = Split-Path $package.Version -Leaf
    $destinationPath = $package.Destination + "\" + $fileName

    if (!(Test-Path -Path $destinationPath -PathType Leaf)) {
	Write-Host "Downloading $packageName ..."
	$webClient = New-Object System.Net.WebClient
	$webClient.DownloadFile($package.url,$destinationPath)
    }
    else {
	Write-Host "$packageName already downloaded."
    }
}

Write-Host -fore Yellow "`nInstalling Packages ..."

foreach ($package in $packages) {
    $packageName = $package.title
    $fileName = Split-Path $package.url -Leaf
    $destinationPath = $package.Destination + "\" + $fileName
    $Arguments = $package.Arguments
    Write-Output "Installing $packageName ..."
    Invoke-Expression -Command "$destinationPath $Arguments"
}
