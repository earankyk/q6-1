module List :
sig
  include module type of List
  val zip : 'a list -> 'b list -> ('a * 'b) list
  val map_fold_left: ('b -> 'a -> ('c*'b)) -> 'b -> 'a list -> ('c list * 'b)
  val tabulate : int -> (int -> 'a) -> 'a list 
end =
struct
  include List
  let zip l1 l2 = map2 (fun x y -> (x,y)) l1 l2 

  let map_fold_left f acc l = 
    let g (l',acc) a = 
      let (b,acc') = f acc a in
        (b::l',acc') in
    let (l',acc') = List.fold_left g ([],acc) l in
      (List.rev l',acc')

  let tabulate n f = 
    let l = Array.to_list @@ Array.make n () in
      List.mapi (fun i _ -> f i) l
end
