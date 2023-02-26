package ApplicationUtils;

enum Format {
	YYYYDDMM,
	DDMMYYYY
}

public class DateFormatter {
	enum Month {
		JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC
	}
	
	private String dateString;
	private Format format;
	
	public DateFormatter(String dateString, String format)
			throws DateFormatException {
		if (!(format.equals("yyyymmdd") || format.equals("ddmmyyyy")))
			throw new DateFormatException("Bad format provided, make sure it is yyyymmdd or ddmmyyyy");
		this.dateString = dateString;
		if (format.equals("yyyymmdd"))
			this.format = Format.YYYYDDMM;
		else if (format.equals("ddmmyyyy"))
			this.format = Format.DDMMYYYY;
	}
	
	public String getLocaleString() {
		String year = "", month = "", day = "";
		if (this.format == Format.YYYYDDMM) {
			year = this.dateString.substring(0, 4);
//			System.out.println(year);
			month = this.dateString.substring(5, 7);
//			System.out.println(month);
			day = this.dateString.substring(8);
//			System.out.println(day);
			
			int i = Integer.parseInt(month);
			for (Month m : Month.values()) {
				if (Month.valueOf(m.name()).ordinal() + 1 == i) {
					month = m.name();
					break;
				}
			}
		} else if (this.format == Format.DDMMYYYY) {
			
		}
		
		return day + " " + month + " " + year;
	}
	
	@Override
	public String toString() {
		return this.getLocaleString();
	}
}
