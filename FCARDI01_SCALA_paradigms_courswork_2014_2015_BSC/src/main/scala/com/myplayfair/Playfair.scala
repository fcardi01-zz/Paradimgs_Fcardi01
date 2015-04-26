/**
 *
 * Playfair.scala || MenuPlayfait object
 * Scala version: 2.11.4
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
import java.io._

object MenuPlayfair {

  def main( args : Array[ String ] ) : Unit = {

    println( "                        PLAYFAIR IN SCALA                                 " )
    println( "__________________________________________________________________________" )

    println()
    println( "               Welcome To The Playfair Main Menu                          " )
    println( "               Franco Cardinali 12th April 2015                           " )
    println( "__________________________________________________________________________" )

    println()
    println( "                              MENU                                         " )
    println()
    println( " Firstly you will be Prompt to insert a keyword to use for encrypt or decrypt" )
    println( " 1 -> Encode > " )
    println( " 2 -> Decode > " )
    println( " 3 -> EXIT from Playfair" )
    println( "__________________________________________________________________________" )

    println()
    println( "                     Example TO ENCRYPT                                   " )
    println( "An anonymous reader sends word of a proof-of-concept Google Chrome browser" )
    println( "extension that steals users' login details. The developer, Andreas Grech, " )
    println( "says that he is trying to raise awareness about security among end users, " )
    println( "and therefore chose Chrome as a test-bed because of its reputation as the " )
    println( "safest browser." )
    println( "__________________________________________________________________________" )
    println()
    println( "                       Example KEYWORD                                    " )
    println( "                        Pennsylvania                                      " )
    println( "__________________________________________________________________________" )

    println()
    print( "Welcome....please digit a keyword => " )
    val keyword = readLine()

    println()
    println( "                        GRID SETUP  5x5                                  " )
    printGridOnScreen( ( cleanUp( keyword.toString+"abcdefghiklmnopqrstuvwxyz" ).distinct ).grouped( 5 ).toList : List[ String ] )

    val flag = true

    try {

      do {
        println()
        print( "Please Choose Option from above menu" )
        println()
        val input = readInt()

        if ( input == 1 ) {
          println()
          println()
          print( "Please Enter The message you like to encrypt with the Keyword just given " )
          println()
          val toEncrypt = readLine()
          val writer = new PrintWriter( new File( "./src/main/scala/testoencode.txt" ) )
          writer.write( toEncrypt.toString )
          writer.close()
          println()
          println( ">> Text To Encode Loaded into file" )
          val messageToEncode = scala.io.Source.fromFile( "./src/main/scala/testoencode.txt" ).getLines()
          println( ">> File Converted Into a String" )
          val toEncode = messageToEncode.mkString

          println( ">> Encoding with keyword: "+cleanUp( keyword.toString ) )
          val startup = startProcess( keyword.toString )
          println( ">> Encoded....." )
          formattedPrinting( encodeMethod( cleanUp( toEncode ), startup ).grouped( 5 ).toList : List[ String ] )

        }
        else if ( input == 2 ) {
          println()
          println()
          print( "Please Enter The message you like to decrypt with the Keyword just given " )
          println()
          val toDecrypt = readLine()
          val writer = new PrintWriter( new File( "./src/main/scala/testodecode.txt" ) )
          writer.write( toDecrypt.toString )
          writer.close()
          println()
          println( ">> Text To Decode Loaded into file" )
          val messageToDecode = scala.io.Source.fromFile( "./src/main/scala/testodecode.txt" ).getLines()
          println( ">> File Converted Into a String" )
          val toDecode = messageToDecode.mkString
          println( ">> Decoding with keyword: "+cleanUp( keyword.toString ) )
          val startup = startProcess( keyword.toString )
          println( ">> Decoded:" )
          println()
          formattedPrinting( decodMethod( cleanUp( toDecode ), startup ).grouped( 5 ).toList : List[ String ] )
        }
        else if ( input == 3 ) {
          println()
          println( "Exiting Gracefully" );
          return
        }
        else {
          println()
          println( "Wrong Option" )
        }
        //KEEP TRYING
      } while ( flag == true )

    }
    catch {
      case inputError : NumberFormatException ⇒ println( "Not an Integer...aborting" )
    }

  }

  //ENCODING
  // if encodeMethod is invoked in the main
  // it will take a string and the grid 5X5  process it with the message
  // moving forward on the Vector (tuple2 object CartesianProduct)
  def stepIn( nTimes : Int ) = ( nTimes + 1 ) % 5
  def encodeMethod( secretMessage : String, coreProcess : CartesianProduct ) : String = procStringList( secretMessage toList, coreProcess, stepIn ).mkString( "" )

  //DECODING
  // if decodeMethod is invoked the behaviour
  // is almost identical than the encoding. but here we are moving backwards
  // 
  def stepBack( nTimes : Int ) = ( nTimes + 4 ) % 5
  def decodMethod( secretMessage : String, coreProcess : CartesianProduct ) : String = procStringList( secretMessage toList, coreProcess, stepBack ).mkString( "" )

  /** startProcess
    * table where one letter of the alphabet is omitted,
    * and the letters are arranged in a 5x5 grid
    * with the key and the Alphabet
    * using the key from the main it will will not replicate same letters
    * distinct.toList will help us to deliver that
    */
  def startProcess( cipherKey : String ) = {

    val toBeMapped = cleanUp( cipherKey+"abcdefghiklmnopqrstuvwxyz" ).distinct.toList
    (
      ( toBeMapped zip ( for ( index ← 0 to 4; inner ← 0 to 4 ) yield ( index, inner ) ) ) toMap,
      ( ( for ( index ← 0 to 4; inner ← 0 to 4 ) yield ( index, inner ) ) zip toBeMapped ) toMap
      )
  }

  /** Filtering only letters,
    * lowercase them and removing the j
    * replacing it with an i instead.
    * this method will return a String as result.
    * Remove any punctuation or characters.
    */
  def cleanUp( toBeCleaned : String ) = {
    toBeCleaned map ( _ toLower ) filter ( _ isLetter ) map ( character ⇒ if ( character == 'j' ) 'i' else character )
  }

  /** Nice Printing 5X5 for out Grid
    * with letters and keyword cleanedUp
    * and formatted properly.
    */
  def printGridOnScreen( args : TraversableOnce[ _ ] ) : Unit = {
    args.foreach( println )
  }

  /** formattedPrinting
    * is used in the main
    * to print the list of
    * chunks by 15 for each line.
    * splitAt is absolutely useful in list of strings
    */
  def formattedPrinting( chunks : List[ String ] ) {

    if ( chunks.length <= 15 )
      println( chunks mkString ( " " ) )
    else {
      val ( head, tail ) = chunks.splitAt( 15 )
      //otherwise print from backwards
      println( head mkString ( " " ) )
      formattedPrinting( tail )
    }
  }

  /** To encode a message, one breaks it into two-letter chunks.
    * Repeated letters in the same * chunk are usually separated by an X.
    * The message, "HELLO ONE AND ALL" would become "HE LX LO ON EA ND AL LX
    */
  def procStringList( characters : List[ Char ], coreProcess : CartesianProduct, direction : Int ⇒ Int ) : List[ Char ] = {

    characters match {

      case beginning :: endTuple :: leftOver if beginning != endTuple ⇒
        val ( a, b ) = tupleProcedure( beginning, endTuple, coreProcess, direction )
        a :: b :: procStringList( leftOver, coreProcess, direction )

      case beginning :: leftOver if leftOver != Nil ⇒
        val ( a, b ) = tupleProcedure( beginning, 'x', coreProcess, direction )
        a :: b :: procStringList( leftOver, coreProcess, direction )

      case List( lastChar ) ⇒
        val ( second, tail ) = tupleProcedure( lastChar, 'x', coreProcess, direction )
        List( second, tail )

      // else
      case _ ⇒ List[ Char ]()
    }
  }

  /** Tuple Procedure meant to emulate
    * the Grid 5*5 process of comparison and
    * in the Playfair uses a Product/serializable  Class.
    *
    * A tuple of 2 elements; the canonical representation of a scala.Product2.
    * ref --> https://github.com/scala/scala/blob/v2.11.6/src/library/scala/Tuple2.scala#L1
    * tuples are called "digraphs"
    */
  def tupleProcedure( head : Char, tail : Char, coreProcess : CartesianProduct, direction : Int ⇒ Int ) = {

    //r for rows and c for columns
    val ( digraphs, toCharacter ) = coreProcess
    val ( r, c ) = digraphs( head )
    val ( r2, c2 ) = digraphs( tail )

    //depending on the direction passed by methods above into the main this will
    // decode or encode
    if ( r == r2 ) {
      ( toCharacter( ( r, direction( c ) ) ), toCharacter( ( r2, direction( c2 ) ) ) )
    }
    else if ( c == c2 ) {
      ( toCharacter( ( direction( r ), c ) ), toCharacter( ( direction( r2 ), c2 ) ) )
    }
    else {
      ( toCharacter( ( r, c2 ) ), toCharacter( ( r2, c ) ) )
    }

  }

  //TYPES

  /** http://www.scala-lang.org/api/current/index.html#scala.Tuple2
    * Product2 is a Cartesian product of 2 components: 2 HashMaps  of Chars (Letters)in this case
    * X is made of two Integer
    * CartesianProduct  IS product of 2 components
    */

  type X = Tuple2[ Int, Int ]
  type CartesianProduct = Tuple2[ Map[ Char, X ], Map[ X, Char ] ]

}



