# Define the root directory
$rootDir = ""

# Check if the root directory exists
if (-not (Test-Path -Path $rootDir -PathType Container)) {
    Write-Host "The specified root directory does not exist: $rootDir"
    exit
}

# Change to the root directory
Set-Location -Path $rootDir

# Prompt for the quantity of copies
$quantity = Read-Host "Enter the quantity of copies"

# Validate the quantity input
if (-not [int]::TryParse($quantity, [ref]$null) -or [int]$quantity -le 0) {
    Write-Host "Invalid quantity. Please enter a positive integer."
    exit
}

# Prompt for the surgery string
$word = Read-Host "Enter the word that will match the pattern <word>-<id>"

# Prompt for the folder name
$folderName = Read-Host "Enter the folder name matching the pattern '$word-<id>'"

# Validate the folder name pattern
if ($folderName -notmatch "^\Q$word\E-\d+$") {
    Write-Host "Invalid folder name. Please enter a name matching the pattern '$word-<id>' where <id> is a positive integer."
    exit
}

# Extract the base name and id from the folder name
$baseName, $id = $folderName -split '-'

# Convert id to an integer
$id = [int]$id

# Check if the folder exists in the root directory
$folderPath = Join-Path -Path $rootDir -ChildPath $folderName
if (-not (Test-Path -Path $folderPath -PathType Container)) {
    Write-Host "Folder '$folderName' does not exist in the root directory."
    exit
}

# Loop to create the specified number of copies
for ($i = 1; $i -le $quantity; $i++) {
    # Increment the id
    $newId = $id + $i

    # Create the new folder name
    $newFolderName = "$baseName-$newId"

    # Create the new folder path
    $newFolderPath = Join-Path -Path $rootDir -ChildPath $newFolderName

    # Copy the folder contents to the new folder
    Copy-Item -Path $folderPath -Destination $newFolderPath -Recurse

    Write-Host "Created copy: $newFolderPath"
}

Write-Host "Completed creating $quantity copies of the folder '$folderName'."