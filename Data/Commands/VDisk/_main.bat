:VDiskMode
set/p TextOS.VDiskModeInput=!TextOS.MountedDrive!:\

call !TextOS.DataFolder!\Commands\VDisk\!TextOS.VDiskModeInput!

if exist !TextOS.VDiskModeInput! "!TextOS.VDiskModeInput!"
goto VDiskMode