# Arizona State University - CSE 205 - VS Code Assignment Boilerplate

A boilerplate layout for CSE 205 console application assignments that allows for Windows users to easily automate test cases.

> NOTE: You *can* delete the `.gitignore` file in the `bin`, `src`, and `test` directories. They are only included so that git will allow for these directories to be pushed, as empty directories are otherwise ignored.

## Requirements

- [Extension Pack for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack)

## Directions to set up automated test cases in VS Code manually

### `src` folder

- Create a `src` folder, all `.java` files will be placed here

### `bin` folder

- Create a `bin` folder, this folder will contain the compiled `.class` file(s).
- If your extensions are working correctly, you should observe this file be populated with the class files for your program automatically after configuring `settings.json`.

### `test` folder

- Create a `test` folder and place all the given input an output text files in here
- Your program's actual output will also be written to "myoutput" text files in this folder for comparison

### `test.ps1` file

- in the `test.ps1` file, paste this code:

```ps1
$name = $args[0]
$numTests = $args[1]

for($i = 1; $i -le $numTests; $i++) {
    if((Test-Path -Path test\input$i.txt -PathType Leaf) -and (Test-Path -Path test\output$i.txt -PathType Leaf)) {
        Write-Output "Testing Case $i"
        Get-Content test\input$i.txt | java -cp bin $name | Out-File -Encoding utf8 test\myoutput$i.txt
        if(Compare-Object -CaseSensitive (Get-Content test\myoutput$i.txt) (Get-Content test\output$i.txt)) {
            Write-Warning "Test Case $i Failed"
            code --diff test\myoutput$i.txt test\output$i.txt
        }
    } else {
        Write-Warning "Failed to locate files for Test Case $i, ensure both input$i.txt and output$i.txt are present in the test directory"
    }
}
```

### `.vscode` Folder

- If you don't already have a .vscode directory, create one.
- Create these two files if they don't exist already and set their contents to this:
1. `settings.json`
```json
{
  "java.project.sourcePaths": ["src"], // Source code
  "java.project.outputPath": "bin" // Build output
}
```

2. `tasks.json`
```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run Tests",
      "type": "shell",
      "command": ".\\test.ps1 ${fileBasenameNoExtension} ${input:numTests}",
      "problemMatcher": [],
      "group": {
        "kind": "build",
        "isDefault": true
      }
    }
  ],
  "inputs": [
    {
      "id": "numTests",
      "type": "promptString",
      "default": "4",
      "description": "Number of test cases"
    }
  ]
}
```
