$workingDir = (Get-Location)
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
        break
    }
    if ($first.HasMoreData) {
        Write-Host $first.ChildJobs[0].Output
    }
    if ($second.HasMoreData) {
        Write-Host $second.ChildJobs[0].Output
    }
    Start-Sleep 4
}
$first | Stop-Job
$second | Stop-Job