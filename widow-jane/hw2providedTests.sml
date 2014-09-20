use "hw2provided.sml";
(* Dan Grossman, Coursera PL, HW2 Provided Tests *)

(* These are just two tests for problem 2; you will want more.

   Naturally these tests and your tests will use bindings defined 
   in your solution, in particular the officiate function, 
   so they will not type-check if officiate is not defined.
 *)

fun all_except_option_test1() = (* correct behavior: returns SOME ["hello", "bye"]*)
    let val s = "hi"
	val ls = ["hello", "hi", "bye"]
    in
	all_except_option(s, ls)
    end

fun all_except_option_test2() = (* correct behavior: returns NONE*)
    let val s = "herro"
        val ls = ["something", "other", "else"]
    in 
	all_except_option(s, ls)
    end

fun get_substitutions1_test1() = (* correct behavior: returns ["Fredrick", "Freddie", "F"]*)
    let val sll = [["Fred", "Fredrick"], ["Elizabeth", "Betty"], ["Freddie", "Fred", "F"]]
        val s = "Fred"
    in
	get_substitutions1(sll, s)
    end

fun get_substitutions1_test2() = (* correct behavior: returns [] *)
    let val sll = [["nothing", "here"], ["or", "even", "here"]]
        val s = "something"
    in
	get_substitutions1(sll, s)
    end


fun get_substitutions1_test3() = (* correct behavior: returns [] *)
    let val sll = [["turtle"], ["hello", "nothing"]]
        val s = "turtle"
    in
	get_substitutions1(sll, s)
    end

fun get_substitutions2_test1() = (* correct behavior: returns ["Fredrick", "Freddie", "F"]*)
    let val sll = [["Fred", "Fredrick"], ["Elizabeth", "Betty"], ["Freddie", "Fred", "F"]]
        val s = "Fred"
    in
	get_substitutions2(sll, s)
    end

fun get_substitutions2_test2() = (* correct behavior: returns [] *)
    let val sll = [["nothing", "here"], ["or", "even", "here"]]
        val s = "something"
    in
	get_substitutions2(sll, s)
    end

fun get_substitutions2_test3() = (* correct behavior: returns [] *)
    let val sll = [["turtle"], ["hello", "nothing"]]
        val s = "turtle"
    in
	get_substitutions2(sll, s)
    end

fun similar_names_test1() = (* correct behavior: returns [{}] *)
    let val sll = [["Fred", "Fredrick"], ["Elizabeth", "Betty"], ["Freddie", "Fred", "F"]]
        val fullname = {first="Fred", middle="W", last="Smith"}
    in
	similar_names(sll, fullname)
    end

fun card_color_test1() = (* correct behavior: returns black *)
let val card = (Clubs, Jack)
in
    card_color(card)
end

fun card_color_test2() = (* correct behavior: returns red *)
let val card = (Diamonds, Queen)
in
    card_color(card)
end

fun card_color_test3() = (* correct behavior: returns black *)
let val card = (Spades, Num(1))
in
    card_color(card)
end

fun card_color_test4() = (* correct behavior: returns red *)
let val card = (Hearts, Num(7))
in
    card_color(card)
end

fun card_value_test1() = (* correct behavior: returns 1*)
let val card = (Spades, Num(1))
in
    card_value(card)
end

fun card_value_test2() = (* correct behavior: returns 9*)
let val card = (Spades, Num(9))
in
    card_value(card)
end

fun card_value_test3() = (* correct behavior: returns 10 *)
let val card = (Spades, Queen)
in
    card_value(card)
end

fun card_value_test4() = (* correct behavior: returns 11*)
let val card = (Spades, Ace)
in
    card_value(card)
end

fun remove_card_test1() = (* correct behavior: raise IllegalMove *)
let val cs = []
    val c = (Spades, Ace)
    val e = IllegalMove
in
    remove_card(cs, c, e)
end

fun remove_card_test2() = (* correct behavior: return [(Clubs, Queen), (Spades, Ace), (Diamonds, Num(1))] *)
let val cs = [(Spades, Ace), (Clubs, Queen), (Spades, Ace), (Diamonds, Num(1))]
    val c = (Spades, Ace)
    val e = IllegalMove
in
    remove_card(cs, c, e)
end

fun remove_card_test3() = (* correct behavior: return [(Spades, Ace), (Clubs, Queen), (Clubs, Queen)] *)
let val cs = [(Spades, Ace), (Clubs, Queen), (Diamonds, Num(1)), (Clubs, Queen)]
    val c = (Diamonds, Num(1))
    val e = IllegalMove
in
    remove_card(cs, c, e)
end

fun remove_card_test4() = (* correct behavior: raise IllegalMove *)
let val cs = [(Hearts, King)]
    val c = (Spades, Ace)
    val e = IllegalMove
in
    remove_card(cs, c, e)
end

fun remove_card_test5() = (* correct behavior: raise IllegalMove *)
    let val cs = [(Clubs,Jack),(Spades,Num(8))]
	val c = (Hearts,Jack)
	val e = IllegalMove
    in
	remove_card(cs,c,e)
    end

fun all_same_color_test1() = (* correct behavior: returns true *)
let val cs = [(Spades, Ace), (Clubs, Queen), (Spades, Num(1))]
in
    all_same_color(cs)
end

fun all_same_color_test2() = (* correct behavior: returns false *)
let val cs = [(Spades, Ace), (Hearts, Queen), (Spades, Num(1))]
in
    all_same_color(cs)
end

fun sum_cards_test1() = (* correct behavior: returns 22 *) 
let val cs = [(Spades, Ace), (Hearts, Queen), (Spades, Num(1))]
in
    sum_cards(cs)
end

fun sum_cards_test2() = (* correct behavior: returns 30 *) 
let val cs = [(Spades, Jack), (Hearts, Queen), (Spades, Num(10))]
in
    sum_cards(cs)
end

fun sum_cards_test3() = (* correct behavior: returns 0 *) 
let val cs = []
in
    sum_cards(cs)
end

fun score_test1() = (* correct behavior: returns 36 *) 
let val cs = [(Spades, Ace), (Hearts, Queen), (Spades, Num(1))]
    val goal = 10
in
    score(cs, goal)
end

fun score_test2() = (* correct behavior: returns 60 *) 
let val cs = [(Spades, Jack), (Hearts, Queen), (Spades, Num(10))]
    val goal = 10
in
    score(cs, goal)
end

fun score_test3() = (* correct behavior: returns 0 *) 
let val cs = [(Spades, Jack)]
    val goal = 10
in
    score(cs, goal)
end

fun score_test4() = (* correct behavior: returns 30 *) 
let val cs = [(Spades, Jack), (Clubs, Queen), (Spades, Num(10))]
    val goal = 10
in
    score(cs, goal)
end

fun score_test5() = (* correct behavior: returns 9 *) 
let val cs = [(Spades, Jack), (Diamonds, Num(1))]
    val goal = 20
in
    score(cs, goal)
end

fun provided_test1 () = (* correct behavior: raise IllegalMove *)
    let val cards = [(Clubs,Jack),(Spades,Num(8))]
	val moves = [Draw,Discard(Hearts,Jack)]
    in
	officiate(cards,moves,42)
    end

fun provided_test2 () = (* correct behavior: return 3 *)
    let val cards = [(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)]
	val moves = [Draw,Draw,Draw,Draw,Draw]
    in
 	officiate(cards,moves,42)
    end

