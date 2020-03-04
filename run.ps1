$workingDir = (Get-Location)

Write-Host "Starting processes ..."
Write-Host "Press any key to close them ..."

$first = Start-Job -ScriptBlock {
    param($workingDir)
    $firstPath = -join ($workingDir, "\first.bat")
    Invoke-Expression -Command $firstPath
} -ArgumentList $workingDir

$second = Start-Job -ScriptBlock {
    param($workingDir)
    $secondPath = -join ($workingDir, "\second.bat")
    Invoke-Expression -Command $secondPath
} -ArgumentList $workingDir

While (Get-Job -State "Running") { 
    if ([console]::KeyAvailable) {
        break;
    }
    if ($first.HasMoreData) {
        Write-Host ("From first:
		" + $first.ChildJobs[0].Output + "
        ")
    }
    if ($second.HasMoreData) {
        Write-Host ("From second:
		" + $second.ChildJobs[0].Output + "
        ")
    }
    Start-Sleep 10
}

Write-Host "All done!!!"
Write-Host "Press any key to continue..."
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null