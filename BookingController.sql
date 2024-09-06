using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ESD_Project.Data; // Ensure this namespace matches your BookingContext location
using ESD_Project.Models; // Import the namespace where Booking is defined

[Route("api/[controller]")]
[ApiController]
public class BookingsController : ControllerBase
{
    private readonly BookingContext _context;

    public BookingsController(BookingContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<Booking>>> GetBookings()
    {
        return await _context.Bookings.ToListAsync();
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<Booking>> GetBooking(int id)
    {
        var booking = await _context.Bookings.FindAsync(id);

        if (booking == null)
        {
            return NotFound();
        }

        return booking;
    }

    [HttpPost]
    public async Task<ActionResult<Booking>> PostBooking(Booking booking)
    {
        _context.Bookings.Add(booking);
        await _context.SaveChangesAsync();

        return CreatedAtAction(nameof(GetBooking), new { id = booking.BookingID }, booking);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> PutBooking(int id, Booking booking)
    {
        if (id != booking.BookingID)
        {
            return BadRequest();
        }

        _context.Entry(booking).State = EntityState.Modified;

        try
        {
            await _context.SaveChangesAsync();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!BookingExists(id))
            {
                return NotFound();
            }
            else
            {
                throw;
            }
        }

        return NoContent();
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteBooking(int id)
    {
        var booking = await _context.Bookings.FindAsync(id);
        if (booking == null)
        {
            return NotFound();
        }

        _context.Bookings.Remove(booking);
        await _context.SaveChangesAsync();

        return NoContent();
    }

    private bool BookingExists(int id)
    {
        return _context.Bookings.Any(e => e.BookingID == id);
    }
}
