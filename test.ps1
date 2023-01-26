$name = $args[0]
$numTests = $args[1]

for($i = 1; $i -le $numTests; $i++) {
    if((Test-Path -Path test\input$i.txt -PathType Leaf) -and (Test-Path -Path test\output$i.txt -PathType Leaf)) {
        
        Get-Content test\input$i.txt | java -cp bin $name | Out-File -Encoding utf8 test\myoutput$i.txt
        if(Compare-Object -CaseSensitive (Get-Content test\myoutput$i.txt) (Get-Content test\output$i.txt)) {
            Write-Host -ForegroundColor Red "[FAIL] Test Case $i"
            code --diff test\myoutput$i.txt test\output$i.txt
        } else {
            Write-Host -ForegroundColor Green "[PASS] Test Case $i"
        }
    } else {
        Write-Warning "Failed to locate files for Test Case $i, ensure both input$i.txt and output$i.txt are present in the test directory"
    }
}
