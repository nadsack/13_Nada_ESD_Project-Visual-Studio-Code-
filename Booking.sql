namespace ESD_Project.Models
{
    public class Booking
    {
        private string facilityDescription;

        public int BookingID { get; set; } // Unique ID for the booking
        public string FacilityDescription { get => facilityDescription; set => facilityDescription = value; } // Description of the facility being booked
        public DateTime BookingDateFrom { get; set; } // Start date of the booking
        public DateTime BookingDateTo { get; set; } // End date of the booking
        public string BookedBy { get; set; } // The name or ID of the person who made the booking
        public string BookingStatus { get; set; } // Status of the booking (e.g., Confirmed, Pending, Cancelled)
    }
}
