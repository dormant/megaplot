# megaplot

## ~/src/megaplot

*MATLAB* scripts to draw various versions of the megaplot.

## plotMegaplot.m

* *plotMegaplot.m* can be run from the *MATLAB* command line, or called from a shell script.
* When used interactively in *MATLAB*, you can specify options interactively or using a configuration file. These are called *config*.m*.
* When called from a shell script, you must use a configuration file.

## MATLAB scripts

| Script       | Function |
| -------------| -------------------|
| *askArgs.m*   | Called by *plotMegaplot.m* and asks for config file, or for every option.|
| *meanJumps.m* | Called by *plotMegaplot.m* and calculates regularly-spaced mean values for irregularly-sampled data. Used for SO2 data.|
| *meanJumpsStdev.m* | Called by *plotMegaplot.m* and calculates regularly-spaced mean values and standard deviation for irregularly-sampled data. Used for SO2 data.|
| *plotGasFum.m* | Standalone script to plot SO2 flux with fumarole temperatures.|
| *plotPhases.m* | Called by *plotMegaplot.m* to add the eruption phases as a background.|

## Shell scripts

| Script       | Function |
| -------------| -------------------|
| *fetchMegaplot.cgi*   | Script for *webobs* to get options and call *plotMegaplotWebobs.sh* remotely.|
| *plotMegaplotCron.sh*   | Run as a cronjob to generate plots regularly.|
| *plotMegaplotWebobs.sh* | Script to be called remotely by *webobs* to draw a megaplot interactively. **UNDER DEVELOPMENT**|
| *testPlotMegaplotCli.sh* | Test command-line scrript.|

## Updating data

### Seismic

* All seismic data is updated when you reply 'Y' to the **question**.
* **String moments need**
* **Problem with SEISAN data.**

### GPS

* Copy data to local directory
```
$ cd ~/src/megaplot/data/gps/gps-auto-final
$ cp /mnt/volcano01/Deformation/GPS_auto/data/final/*.txt .
```
* In MATLAB
```
>> fetchGps
```

### SO2

* Add latest mean and std dev data to *./data/gas/SO2_traverse_data_from_TC_latest.csv*.
* Data will be updated when you  reply 'Y' to the **question**.

### Other

## Author

Roderick Stewart, Dormant Services Ltd

rod@dormant.org

https://services.dormant.org/

## Version History

* 3.0
    * Working version

## License

This project is the property of Montserrat Volcano Observatory.
