import java.awt.Color;
import java.awt.Graphics;

public abstract class HangmanGraphics extends Hangman{
	
	/** default constructor sets size of window */
	public HangmanGraphics(){
		setSize(400, 400);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
	}
	
	/** paint method */
	public void paint(Graphics canvas){
		super.paint(canvas);
		canvas.drawLine(139, 0, 139, 100);
		canvas.drawLine(140, 0, 140, 100);
		canvas.drawLine(141, 0, 141, 100);
		canvas.drawString(getTries() + " attempts remain.", 200, 70);
		
		if (getTries() < 6)
			canvas.drawOval(100, 100, 80, 80);
		if (getTries() < 5)
			canvas.drawLine(140, 180, 140, 300);
		if (getTries() < 4)
			canvas.drawLine(140, 300, 80, 380);
		if (getTries() < 3)
			canvas.drawLine(140, 300, 210, 380);
		if (getTries() < 2)
			canvas.drawLine(140, 180, 80, 250);
		if (getTries() < 1)
			canvas.drawLine(140, 180, 200, 250);
		
		if (getTries() > 0 && getWordCorrect() == false)
			canvas.drawChars((getArray()), 0, (getWordActual()).length(), 200, 50);
		else
			canvas.drawString(getWordActual(), 200, 50);
	}
	
	/** sets window visible */
	public void drawHangman(){
		setVisible(true);
	}
	
	/** sets window invisible */
	public void eraseHangman(){
		setVisible(false);
	}
}
