(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

fun all_except_option(remove: string, ss: string list) =
    case ss of [] => NONE 
            | s::ss' => if same_string(s, remove)
			then SOME ss'
			else 
			    let
				val the_rest = all_except_option(remove, ss')
			    in
				case the_rest of NONE => NONE
					      |  SOME the_rest => SOME (s::the_rest) 
			    end

fun get_substitutions1(lls: string list list, s: string) = 
    case lls of [] => []
	     |  ls::ls2  => let
		                val removals = all_except_option(s, ls)
				val result = get_substitutions1(ls2, s)
			    in 
				case removals of NONE => result
					    |  SOME i => i @ result 
			    end	

fun get_substitutions2(lls: string list list, s: string) =
    let fun sub_helper(lls: string list list, acc: string list) =
	    case lls of [] => acc
	     |  ls::ls2  => let
		                val removals = all_except_option(s, ls)
			    in 
				case removals of NONE => sub_helper(ls2, acc)
					    |  SOME i => sub_helper(ls2, i @ acc) 
			    end	    
    in
	sub_helper(lls, [])
    end

fun similar_names(all_substitutions: string list list, fullname: {first:string, middle:string, last:string}) =
    case fullname of
	{first=fname, middle=mname, last=lname} =>
	let val subs_for_first_name = get_substitutions2(all_substitutions, fname)
	    fun make_list_of_records_given_subs(subs: string list) =
		case subs of [] => fullname::[]
					 |  sub1::rest_subs => {first=sub1, middle=mname, last=lname}::make_list_of_records_given_subs(rest_subs) 
	in
	    make_list_of_records_given_subs(subs_for_first_name)
	end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

fun card_color(input_card: card) =
    case input_card of (Clubs, _) => Black
     |  (Diamonds, _) => Red
     |  (Hearts, _) => Red
     |  (Spades, _) => Black
   
fun card_value(input_card: card) =
case input_card of (_, Ace) => 11
		|  (_, King) => 10
		|  (_, Queen) => 10
		|  (_, Jack) => 10
		| (_, Num(i)) => i
    
fun remove_card(cs: card list, c: card, e:exn) =
    let fun remove_cards_helper(cards: card list, acc: card list) = 
	case cards of [] => raise e
		|  card1::rest_of_cards =>
		   if card1 = c
		   then acc @ rest_of_cards
		   else
		       remove_cards_helper(rest_of_cards, acc @ (card1::[]) )
    in
	remove_cards_helper(cs, [])
    end

fun all_same_color(cs: card list) =
case cs of [] => true
	|  onlyone::[] => true 
	|  first::second::rest =>
	   let val first_color = card_color(first)
	       val second_color = card_color(second)
	   in
	       (first_color = second_color) andalso all_same_color(rest) 
	   end

fun sum_cards(cs: card list) =
let fun sum_cards_helper(cards: card list, acc) = 
    case cards of [] => acc
		  | first::rest => sum_cards_helper(rest, card_value(first) + acc) 
in
    sum_cards_helper(cs, 0)
end

fun score(cs: card list, goal: int) =
let 
    val sum = sum_cards(cs)
    val prelim_score = if sum > goal then (3 * (sum - goal)) else (goal - sum)
in
    if all_same_color(cs)
    then prelim_score div 2
    else prelim_score 
end

fun officiate(cs: card list, ms: move list, goal: int) = 
let fun officiate_helper(hand: card list, moves: move list) =
	case moves of [] => score(hand, goal)
			|  Discard(i)::rest_moves =>
			   officiate_helper(remove_card(hand,i, IllegalMove), rest_moves)
			|  Draw::rest_moves =>
			   case cs of [] => score(hand, goal)
				    | c::rest =>  
				      if sum_cards(c::hand) > goal 
				      then
					  score(c::hand, goal)
				      else
					  officiate_helper(c::hand, rest_moves)
in
    officiate_helper([], ms)
end
