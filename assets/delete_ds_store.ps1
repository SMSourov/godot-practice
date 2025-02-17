# This script recursively deletes all ".DS_Store" files within a specified folder.

# Get the path to the folder you want to search. 
$FolderPath = "$PWD"

# Get all files with the ".DS_Store" extension within the specified folder and its subfolders.
$DS_StoreFiles = Get-ChildItem -Path $FolderPath -Include "*.DS_Store" -Recurse

# Delete the found files.
if ($DS_StoreFiles) {
    foreach ($file in $DS_StoreFiles) {
        Write-Host "Deleting: $($file.FullName)"
        Remove-Item -Path $file.FullName -Force 
    }
} else {
    Write-Host "No '.DS_Store' files found."
}