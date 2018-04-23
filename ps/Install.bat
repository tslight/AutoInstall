$src = $PSScriptRoot
$src = $src | Split-Path -Parent
$src = "$src\Installers"

$pkgs = @(
    @{title='Adobe Reader';args=' /msi EULA_ACCEPT=YES /qn /quiet'},
    @{title='Carbon Black';args=' /S'},
    @{title='Egnyte Connect';args=' /qn /quiet'},
    @{title='Egnyte Office';args=' /qn /quiet'},
    @{title='Egnyte WebEdit';args=' /qn /quiet'},
    @{title='FortiClient';args=' /quiet /norestart /INSTALLLEVEL=3'},
    @{title='Google Chrome';args=' /silent /install'},
    @{title='MimeCast';args=' /quiet /norestart'},
    @{title='VLC';args=' /L=1033 /S'}
)

Write-Host -fore Yellow "`nInstalling Packages ..."
foreach ($pkg in $pkgs)
{
    $pkgName = $pkg.title
    $installer = get-childitem "$src\$pkgName" | where {$_.Extension -eq ".exe" -or $_.Extension -eq ".msi"} | select -ExpandProperty name
    $path = "$src\$pkgName\$installer"
    $path = ($path -Replace ' ', '` ')
    $args = $pkg.args
    Write-Output "Installing $pkgName ..."
    $cmd = "$path $args"
    Invoke-Expression -Command $cmd
}
