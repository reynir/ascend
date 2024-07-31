let pointsSpeedPerTurn = 12

let sf = Format.sprintf

type pos =
    { row : int
    ; col : int
    }

let listMake n v = List.init n (fun _ -> v)

let listSet i v =
    List.mapi (fun ci ov -> if ci <> i then ov else v)

let contains l v = List.find_opt ((=) v) l |> Option.is_some

let range min max = List.init (max - min + 1) (fun i -> i + min)

let rn min max = Random.int_in_range ~min ~max

let oneIn n = rn 0 (n - 1) = 0

let rnIndex l =
    assert (List.length l > 0);

    let iLast = List.length l - 1 in
    rn 0 iLast

let rnItem l =
    assert (List.length l > 0);

    List.nth l (rnIndex l)

let rnRelative l =
    let freqTotal =
        List.map (fun (i, freq) -> freq) l
        |> List.fold_left (+) 0
    in
    assert (freqTotal > 0);

    let rec aux ix = function
        | [] -> assert false
        | (i, freq)::tl when ix <= freq -> i
        | (_, freq)::tl -> aux (ix - freq) tl
    in
    let ix = rn 1 freqTotal in
    aux ix l

type roll =
    { rolls : int
    ; sides : int
    }

let doRoll roll =
    range 1 roll.rolls
    |> List.map (fun _ -> rn 1 roll.sides)
    |> List.fold_left (+) 0
