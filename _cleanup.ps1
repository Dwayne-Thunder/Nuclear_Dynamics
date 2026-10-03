$repo = $PSScriptRoot
$mods = Join-Path $env:APPDATA 'Factorio\mods'
@(
    '_rebrand_do.ps1',
    '_rebrand_check.ps1',
    '_fix_mod_paths.ps1',
    '_rename_mod.ps1'
) | ForEach-Object {
    $p = Join-Path $repo $_
    if (Test-Path -LiteralPath $p) { Remove-Item -LiteralPath $p -Force; Write-Host ("removed {0}" -f $_) }
}
Write-Host '=== MODS ==='
Get-ChildItem -LiteralPath $mods | Where-Object {
    $_.Name -like 'True-Nukes_Continued*' -or $_.Name -like 'Nuclear*'
} | ForEach-Object {
    $item = Get-Item -LiteralPath $_.FullName -Force
    '{0} | {1} | {2}' -f $item.Name, $item.LinkType, ($item.Target -join ';')
}
Write-Host ('repoHasNuclear={0}' -f (Test-Path -LiteralPath (Join-Path $repo 'Nuclear_Dynamics\info.json')))
Write-Host ('repoHasOld={0}' -f (Test-Path -LiteralPath (Join-Path $repo 'True-Nukes_Continued_0.3.36')))
