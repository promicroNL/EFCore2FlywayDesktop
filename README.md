# Introduction
Project data for an article on Redgate.com
Combining the power of EF Core with FWD!

## Updated CLI usage

This project originally used the `flyway-dev` command line interface. It has now
been updated to use the standard `flyway` CLI. For details on migrating your
workflow, see Redgate's guide on
[migrating from flyway-dev to flyway CLI](https://documentation.red-gate.com/fd/tutorial-migrating-from-flyway-dev-to-flyway-cli-277579350.html)
and the article on
[automating Flyway Desktop development](https://www.red-gate.com/hub/product-learning/flyway/automating-flyway-desktop-development).

Scripts in this repo demonstrate the new commands, such as `flyway diff model`
to update the schema model and `flyway migrate` to apply migrations.

## Workflows

Three sample workflows are included for 2025:

- **Simple** – converts EF Core migrations to Flyway scripts.
- **Inverted** – uses existing Flyway migrations to update the schema model.
- **Hybrid** – applies EF Core migrations and synchronizes with Flyway.

Each `Flyway.*` folder contains a PowerShell script and a pipeline definition
to run the scenario end-to-end.

                           _)\.-.                                                _/\__          
         .-.__,___,_.-=-. )\`  a`\_                                        ---==/    \\         
     .-.__\__,__,__.-=-. `/  \     `\     ___  _ _ _  ___           ___  ___    |.    \|\       
     {~,-~-,-~.-~,-,;;;;\ |   '--;`)/     | __|| | | || _ \        | __|| __|   |  )   \\\      
      \-,~_-~_-,~-,(_(_(;\/   ,;/         | _| | | | |||_| |       | _| | _|    \_/ |  //|\\    
       ",-.~_,-~,-~,)_)_)'.  ;;(          |_|  \_____/|___/    VS  |___||_|         /   \\\/\\  
         `~-,_-~,-~(_(_(_(_\  `;\                                                   \    \/\\/\/

