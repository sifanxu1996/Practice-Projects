public class HangGame extends HangmanGraphics{

	/** default constructor */
	public HangGame(){
		readFromFile();
	}
	
	/** main method: called to initiate a new game */
	public void hangStart(){
		reset();
		selectWord();
		System.out.println(getWordActual());
		drawHangman();
		do{
			readInput();
			checkGuess();
			repaint();
		}while (getWordCorrect() == false && getTries() > 0);
		checkVictory();
		eraseHangman();
	}
}
