package ApplicationUtils;

public class DateFormatException extends Exception {
	DateFormatException() { super("Bad date format"); }
	DateFormatException(String msg) {
		super(msg);
	}
	
	@Override
	public String toString() { return this.getMessage(); }
}