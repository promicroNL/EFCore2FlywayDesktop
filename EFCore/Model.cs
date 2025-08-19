using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;

public class TWContext : DbContext
{
    public DbSet<Distillery> Distilleries { get; set; }
    public DbSet<Bottle> Bottles { get; set; }
    public DbSet<Customer> Customers { get; set;}
    public DbSet<Tasting> Tastings { get; set;}
    public DbSet<Order> Orders { get; set;}

    // public string DbPath { get; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlServer("Data Source=(localdb)\\MSSQLLocalDB; Initial Catalog=TasteWhisky;");
    }


    // public TWContext()
    // {
    //     var folder = Environment.SpecialFolder.LocalApplicationData;
    //     var path = Environment.GetFolderPath(folder);
    //     DbPath = System.IO.Path.Join(path, "TasteWhisky.db");
    // }

    // // The following configures EF to create a Sqlite database file in the
    // // special "local" folder for your platform.
    // protected override void OnConfiguring(DbContextOptionsBuilder options)
    //     => options.UseSqlite($"Data Source={DbPath}");
        
}

public class Bottle
{
    public int Id { get; set; }
    public string? Name { get; set; }
    public Distillery? Distillery { get; set; }
    public int Age { get; set; }
    public float AlcoholByVolume { get; set; }
    public int WhiskyBaseId { get; set; }
}

public class Tasting
{
    public int Id { get; set; }
    public Bottle? Bottle { get; set; }
    public Customer? Customer { get; set; }
    public DateTime Date { get; set; }
    public int Rating { get; set; }
    public string? Notes { get; set; }
    public int NYCRating { get; set; } 
}

public class Customer
{
    public int Id { get; set; }
    public string? FirstName { get; set; }
    public string? LastName { get; set; }
    public DateTime DateOfBirth { get; set; }
    public string? Address {get; set; }
}

public class Distillery
{
    public int Id { get; set; }
    public string? Name { get; set; }
    public string? Location { get; set; }
}
public class Order
{
    public int Id { get; set; }
    public Customer? Customer { get; set; }
    public DateTime Date { get; set; }
    public int Total { get; set; }
    public Bottle? Bottle { get; set; }
}