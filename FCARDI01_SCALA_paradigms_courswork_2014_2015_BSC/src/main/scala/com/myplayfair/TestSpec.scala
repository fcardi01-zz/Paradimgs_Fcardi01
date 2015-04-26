/**
 *
 * TestSpec.scala || PlayfairTesting class
 * Scala version: 2.11.4
 * Scalatest Version: 2.11-2.2.4
 * Client VM: Java 1.7.0_40
 * IDE: IntelliJ IDEA 14.0.3
 * @author Franco Cardinali
 * fcardi01
 * Assignment valid for 25% mark of  Paradigms
 * 5th Year Part Time of BCs in Computing
 * 12-April-2015
 *
 **/

package com.myplayfair
import org.scalatest.FunSuite
import org.scalatest.Assertions

class  PlayfairTesting extends  FunSuite with Assertions {

  /**
   * SETTING UP VARIABLES
   */

  val keyword = "Pennsylvania"
  val MymessageToencript = "John Fitzgerald Kennedy (May 29, 1917 – November 22, 1963)"
  val MymessageToencript2 = "F-=-r;;a,nC/o//C;;a''rd//??@JN---alJ"
  val toBeMapped = ("Pennsylvania" + "abcdefghiklmnopqrstuvwxyz").distinct
  val listTest = List ("F","R","A","N","C","O")
  val classExpectedHash = (listTest zip (for (index <- 0 to 4; inner <- 0 to 4) yield (index, inner))).toMap.getClass.toString
  val classExpectedTuple2 = (MenuPlayfair.startProcess("AnyKeyWIllDo")).getClass.toString
  val expectedLenght = (listTest zip (for (index <- 0 to 4; inner <- 0 to 4) yield (index, inner))).size


  // ACTUAL TESTING

  test ("Here some Data Driven and Isolation Test In Here it is tested the functionality of the methods") {


    //Note still to be lowercased and eliminating the y from the equation
    assert(toBeMapped == "Pensylvaibcdfghkmopqrtuwxz")

    //Finally the cleanup Method does replace the Y with I
    // eliminates any special character and upper cases.
    assert(MenuPlayfair.cleanUp(MymessageToencript) == "iohnfitzgeraldkennedymaynovember")
    assert(MenuPlayfair.cleanUp(MymessageToencript2) == "francocardinali")

    /** Agreed tha 26 are the numbers of letter in the English alphabet
      * this test proves that passing a key word and an alphabet they will be
      * both filtered and distinctly instantiated* */
    assert(toBeMapped.length == 26)

    /** expectedLenght is the size of the List that
      * 1 one the startProcess method function will
      * "fold" a the flatten playfair decoding grid
      * in this case i have passed a test list "F","R","A","N","C","0",
      * * */
    assert(expectedLenght == 6)

    /** Simply Asserting that methods and methods component
      * are returning what they meant to return as "Type"
      * and Classes * */
    assert(classExpectedTuple2 == "class scala.Tuple2")
    assert(classExpectedHash == "class scala.collection.immutable.HashMap$HashTrieMap")



    //One se of test
    // val encryptKey = "franco"
    // val encrytping = "This is London! The French speaking to the French..."
    // val expectedEncrytping ="plkqk qheae efplo nnbcf kptod slreu eplor alefm"
    //  val startup = startProcess(keyword.toString)
    // println(">> Encoded.....")
    // formattedPrinting(encodeMethod(cleanUp(toEncode), startup).grouped(5).toList: List[String])

    // Good Old Days .... Radio Londres!!!

    /** Encoder Testing
      *
      * expectedEncrypting is a one line string; Playfair Menu
      * it is printed in chunks made of 5 letters separated by space.
      * The purpose of this test is purely to assert the the expected result
      * I have used an famous Radio Londres phrase during WW2 transmitted from
      * London to th French soil. as a Key is used 'franco'
      *
      * * */
    val encryptKey = "franco"
    val encrypting = "This is London! The French speaking to the French..."
    val expectedEncrypting = "plkqkqheaeefplonnbcfkptodslreueploralefm"
    val startupForEncode = MenuPlayfair.startProcess(encryptKey.toString)
    val actualResultEncoded = (MenuPlayfair.encodeMethod(MenuPlayfair.cleanUp(encrypting), startupForEncode).grouped(5).toList: List[String]).mkString

    assert(actualResultEncoded == expectedEncrypting)

    //WithClue Assertion Testing exceptions

    /**
     * length is 40 but last charAt index is 39 ... so Yes exception is expected
     * why this? is just expecting the right length of characters after Encoded
     * actualResultEncoded.charAt(39) this is right but in this test would give you Test Failed
     * as the compiler was expecting a java.lang.StringIndexOutOfBoundsException
     * actualResultDecoded.length = 40 ---> which is 39 +1
     */


    withClue("Testing Out Of Bound Exceptions") {
      intercept[StringIndexOutOfBoundsException] {
        actualResultEncoded.charAt(actualResultEncoded.length)
      }}





    /** Decoder Testing:
      *
      * expectedDecoding is a one line string; Playfair Menu
      * it is printed in chunks made of 5 letters separated by space.
      * The purpose of this test is purely to assert the the expected result
      * I have used an famous Radio Londres phrase during WW2 transmitted from
      * London to the French soil. as a Key is used 'franco'
      *
      * * */
    val decodeKey = "franco"
    val decoding = "plkqk qheae efplon nbcfk ptods lreue ploral efm"
    val expectedDecoding = "thisislondonthefrenchspeakingtothefrench"
    val startupForDecode = MenuPlayfair.startProcess(decodeKey.toString)
    val actualResultDecoded = (MenuPlayfair.decodMethod(MenuPlayfair.cleanUp(decoding), startupForDecode).grouped(5).toList: List[String]).mkString

    assert(actualResultDecoded == expectedDecoding)

    //WithClue Assertion Testing exceptions

    /**
     * length is 40 but last charAt index is 39 ... so Yes exception is expected
     * why this? is just expecting the right length of characters after Decoding
     */
    withClue("Testing Out Of Bound Exceptions") {
      intercept[StringIndexOutOfBoundsException] {
        actualResultDecoded.charAt(actualResultDecoded.length)


      }
    }




    // StepIn Stepback Methods

    val stepBackInt = 5
    val stepBackIntTest = 4   //(5+4) %5
    val stepBackResult = MenuPlayfair.stepBack(stepBackInt)

    assert(stepBackResult == stepBackIntTest)



    val stepInInt = 5
    val stepInTest = 1 ////(5+1) %5
    val stepInResult = MenuPlayfair.stepIn(stepInInt)

    assert(stepInResult == stepInTest)






  }

}