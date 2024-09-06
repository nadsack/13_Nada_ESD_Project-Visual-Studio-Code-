using Microsoft.EntityFrameworkCore;
using ESD_Project.Models; // Import namespace where Booking is defined

namespace ESD_Project.Data
{
    public class BookingContext : DbContext
    {
        public BookingContext(DbContextOptions<BookingContext> options)
            : base(options)
        {
        }

        // Ensure this DbSet is defined
        public DbSet<Booking> Bookings { get; set; }
    }
}
