import java.util.Random;
import java.util.Scanner;
import java.util.Arrays;
import java.util.List;
import java.util.*;
import java.io.*;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

public class Hangman extends JFrame{
	/** create array of Strings for wordbank */
	List<String> word = new ArrayList<String>();
	
	private String wordActual;
	private String wordGuess;
	private char[] wordArray = new char[20];
	private int numberTries;
	private boolean wordCorrect;
	
	public void readFromFile(){
		String fileName = "wordBank.txt";
		Scanner fileScan = null;
		try{
			fileScan = new Scanner(new File(fileName));
		}
		catch(FileNotFoundException e){
		}
		while(fileScan.hasNext()){
			word.add(fileScan.next());
		}
		fileScan.close();
	}
	
	/** resets the instance variables */
	public void reset(){
		numberTries = 6;
		wordCorrect = false;
		for(int index = 0; index < 20; index++){
			wordArray[index] = '*';
		}
	}
	
	/** selects a random word from the String[] array*/
	public void selectWord(){
		int index = new Random().nextInt(word.size());
		wordActual = word.get(index);
	}
	
	/** selects a word input into the parameter
	 *  @param a word for the computer to guess
	 */
	public void selectWord(String aWord){
		wordActual = aWord;
	}
	
	/** prompts user for input */
	public void readInput()
	{
		wordGuess = JOptionPane.showInputDialog("Guess the letters in the word or guess the word itself.");
	}
	
	/** prompts computer for input */
	public void readInput(String aGuess)
	{
		wordGuess = aGuess;
	}
	
	/** checks the input for guess */
	public void checkGuess()
	{
		if(wordGuess.length() > 1)
			checkWord();
		
		else if(wordGuess.length() == 1)
			checkLetter();
			
		else
			readInput();
	}
	
	/** checks the input if the input is longer than 1 */
	private void checkWord(){
		if(wordGuess.equalsIgnoreCase(wordActual)){
			wordCorrect = true;
		}
		else{
			wordCorrect = false;
			numberTries--;
		}
	}
	
	/** checks the input if the input is of length 1 */
	private void checkLetter(){
		boolean charGuessed = false;
		char letterGuess = wordGuess.charAt(0);
		for(int index = 0; index < wordActual.length(); index++){
			if(letterGuess == wordActual.charAt(index)){
				charGuessed = true;
				wordArray[index] = letterGuess;
			}
		}
		
		if(charGuessed == false){
			numberTries--;
			JOptionPane.showMessageDialog(null, "Incorrect letter.");
		}
		else{
			JOptionPane.showMessageDialog(null, "Correct letter!");
			checkArray();
		}
	}
	
	/** checks the array to see if all letters have been guessed */
	private void checkArray(){
		wordCorrect = true;
		for(int index = 0; index < wordActual.length(); index++){
			if(wordArray[index] == '*')
				wordCorrect = false;
		}
	}
	
	/** checks if the game has completed with a victory */
	public void checkVictory(){
		if(wordCorrect == true){
			JOptionPane.showMessageDialog(null, "Correct! You found the word in " + (7 - numberTries) + "  tries!");
		}
		else{
			JOptionPane.showMessageDialog(null, "You are out of tries.");
		}
	}
	
	/**
	 * @return  the number of attempts remaining
	 */
	public int getTries(){
		return numberTries;
	}
	
	/**
	 * @return if the word has been correctly guessed
	 */
	public boolean getWordCorrect(){
		return wordCorrect;
	}
	
	/**
	 * @return the word that must be guessed
	 */
	public String getWordActual(){
		return wordActual;
	}
	
	/**
	 * @return the array of the word to be guessed
	 */
	public char[] getArray(){
		return wordArray;
	}
}
