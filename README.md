# assignment_boilerplate

This is a boilerplate layout for CSE205 assignments to allow for MacOS users to use test cases in vscode for java development

Special thanks to `Ryan Woo` for setting everything up, this is a simply template for students to use based off of `HIS` code with my commets to allow for better understanding for student who want to know what certain code is doing lol

### NOTE: You `CAN` delete the `.gitignore` file in the `bin`, `src`, and `test` folder. They are just there so that github would allow for the folders to be pushed because git doesn't allow for empty directory. If you are wanting to know why git doesn't allow for that, a quick explanation is below.
 - git doesn't actually ignore empty directories. It actually ignores all directories. In Git, directories exist only implicitly, through their contents. Empty directories have no contents, so therefore they don't exist.

## Directions to set up test cases in vsode for MacOS users

### `.vscode` Folder

- If you don't already have a .vscode file, create one.
- You should have two files in the `.vsode`

  1.) `settings.json`

  ```
  {
    "version": "2.0.0",
    "tasks": [
      {
        "label": "Run Tests",
        "type": "shell",
        "command": "./test.sh ${fileBasenameNoExtension}",
        "problemMatcher": [],
        "group": {
          "kind": "build",
         "isDefault": true
        }
      }
    ]
  }
  ```

### `bin` folder

- Create a `bin` folder, this folder should hold all of your .class file. When you run the `Java: run test` it will make them automatically

### `src` folder

- Create a `src` folder and it should hold all you `.java` files

### `test` folder

- Create a `test` folder and it should hold all you input an output files
- will output all your myoutput files into this folder for you to compare with.

### `test.sh` file

- in the `test.sh` file, paste this code:

```json:
  #!/bin/bash
  for ((i=1; i<=4; i++)) do
      echo "Testing case $i" # prints which test case number it's currently testing

      # Compiles the java file and runs it with the input file and outputs the  result to myout$i.txt(depends on which test case it's currently testing)
      java -cp bin/ $1 < test/input$i.txt > test/myout$i.txt
      diff test/myout$i.txt test/output$i.txt
  done
```
