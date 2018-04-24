$source = 'W:\Scripts\Toby\pkgps\installers'

If (!(Test-Path -Path $source -PathType Container))
{
    New-Item -Path $source -ItemType Directory | Out-Null
}

$packages = @(
    @{title='Chrome';url='http://dl.google.com/chrome/install/375.126/chrome_installer.exe';Arguments=' /silent /install';Destination=$source},
    @{title='Reader';url='http://ardownload.adobe.com/pub/adobe/reader/win/AcrobatDC/1801120035/AcroRdrDC1801120035_en_US.exe';Arguments=' /msi EULA_ACCEPT=YES /qn /quiet';Destination=$source}
    @{title='VLC';url='https://get.videolan.org/vlc/3.0.0/win64/vlc-3.0.0-win64.exe';Arguments=' /L=1033 /S';Destination=$source}
)

Write-Host -fore Yellow "`nDownloading Packages ..."
foreach ($package in $packages)
{
    $packageName = $package.title
    $fileName = Split-Path $package.url -Leaf
    $destinationPath = $package.Destination + "\" + $fileName

    If (!(Test-Path -Path $destinationPath -PathType Leaf))
    {
	Write-Host "Downloading $packageName ..."
	$webClient = New-Object System.Net.WebClient
	$webClient.DownloadFile($package.url,$destinationPath)
    }
    else {
	Write-Host "$packageName already downloaded."
    }
}

Write-Host -fore Yellow "`nInstalling Packages ..."
foreach ($package in $packages)
{
    $packageName = $package.title
    $fileName = Split-Path $package.url -Leaf
    $destinationPath = $package.Destination + "\" + $fileName
    $Arguments = $package.Arguments
    Write-Output "Installing $packageName ..."
    Invoke-Expression -Command "$destinationPath $Arguments"
}
