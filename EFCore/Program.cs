using System;
using System.Linq;

using (var context = new TWContext())
{
    // Create a new distillery
    var glenfiddich = new Distillery
    {
        Name = "Glenfiddich",
        Location = "Dufftown, Scotland"
    };

    Console.WriteLine("Adding distillery to database...");

    // Add the distillery to the database
    context.Distilleries.Add(glenfiddich);

    // Create a new bottle
    var bottle = new Bottle
    {
        Name = "Glenfiddich 15 Year Old",
        Distillery = glenfiddich,
        Age = 15,
        AlcoholByVolume = 40.0f
    };

    Console.WriteLine("Adding bottle to database...");

    // Add the bottle to the database
    context.Bottles.Add(bottle);

    // Create a new customer
    var customer = new Customer
    {
        FirstName = "John",
        LastName = "Doe",
        DateOfBirth = new DateTime(1970, 1, 1)
    };

    Console.WriteLine("Adding customer to database...");

    // Add the customer to the database
    context.Customers.Add(customer);

    // Create a new tasting
    var tasting = new Tasting
    {
        Bottle = bottle,
        Customer = customer,
        Date = DateTime.Now,
        Rating = 4,
        Notes = "Nice balance of flavors"
    };

    Console.WriteLine("Adding tasting to database...");

    // Add the tasting to the database
    context.Tastings.Add(tasting);

    var order = new Order
    {
        Customer = customer,
        Date = DateTime.Now,
        Total = 10,
        Bottle = bottle
    };

    Console.WriteLine("Adding order to database...");

    // Add the tasting to the database
    context.Orders.Add(order);

    Console.WriteLine("Saving changes to database...");

    // Save the changes to the database
    context.SaveChanges();

    Console.WriteLine("Done!");
}
