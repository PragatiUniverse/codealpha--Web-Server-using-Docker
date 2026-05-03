# PowerShell script to take screenshot of the screen
# Run this to capture the current screen as screenshot.png

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$screen = [System.Windows.Forms.Screen]::PrimaryScreen
$bitmap = New-Object System.Drawing.Bitmap $screen.Bounds.Width, $screen.Bounds.Height
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.CopyFromScreen($screen.Bounds.X, $screen.Bounds.Y, 0, 0, $screen.Bounds.Size)
$bitmap.Save("$PSScriptRoot\screenshot.png", [System.Drawing.Imaging.ImageFormat]::Png)

Write-Host "Screenshot saved as screenshot.png in the current directory"