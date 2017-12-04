(module
  ;; 0-64 reserved for param block
  (memory (export "memory") 10 1000)

  (func $keccak (export "keccak") (param $ctx i32) (param $ptr i32)
  (local $v0 i64)
  (local $v1 i64)
  (local $v2 i64)
  (local $v3 i64)
  (local $v4 i64)
  (local $k0 i64)
  (local $k1 i64)
  (local $k2 i64)
  (local $k3 i64)
  (local $k4 i64)

  ;; v[x] = a[x] ^ a[x + 5] ^ a[x + 10] ^ a[x + 15] ^ a[x + 20];
  (set_local $v0 (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 0)))
      (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 40)))
        (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 80)))
          (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 120)))
            (i64.load (i32.add (get_local $ctx) (i32.const 160)))
            )
          )
        )
      )
    )

  (set_local $v1 (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 8)))
      (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 48)))
               (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 88)))
                 (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 128)))
                   (i64.load (i32.add (get_local $ctx) (i32.const 168)))
          )
        )
      )
    )
  )

  (set_local $v2 (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 16)))
      (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 56)))
        (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 96)))
          (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 136)))
                   (i64.load (i32.add (get_local $ctx) (i32.const 176)))
          )
        )
      )
    )
  )

  (set_local $v3
    (i64.xor
     (i64.load (i32.add (get_local $ctx) (i32.const 24)))
      (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 64)))
        (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 104)))
          (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 144)))
           (i64.load (i32.add (get_local $ctx) (i32.const 184)))
          )
        )
      )
    )
  )

  (set_local $v4
    (i64.xor
     (i64.load (i32.add (get_local $ctx) (i32.const 32)))
       (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 72)))
         (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 112)))
           (i64.xor (i64.load (i32.add (get_local $ctx) (i32.const 152)))
            (i64.load (i32.add (get_local $ctx) (i32.const 192)))
            )
           )
         )
       )
    )

  ;; k[0] = ROTL64(v[1], 1) ^ v[4];
  (set_local $k0
    (i64.xor
     (get_local $v4)
       (i64.rotl
        (get_local $v1)
         (i64.const 1)
         )
       )
    )

  ;; k[1] = ROTL64(v[2], 1) ^ v[0];
  (set_local $k1
    (i64.xor
     (get_local $v0)
      (i64.rotl
       (get_local $v2)
        (i64.const 1)
        )
      )
    )

  ;; k[2] = ROTL64(v[3], 1) ^ v[1];
  (set_local $k2
    (i64.xor
     (get_local $v1)
      (i64.rotl
       (get_local $v3)
        (i64.const 1)
        )
      )
    )

  ;; k[3] = ROTL64(v[4], 1) ^ v[2];
  (set_local $k3
    (i64.xor
     (get_local $v2)
      (i64.rotl
       (get_local $v4)
        (i64.const 1)
        )
      )
    )

  ;; k[4] = ROTL64(v[0], 1) ^ v[3];
  (set_local $k4
    (i64.xor
     (get_local $v3)
      (i64.rotl
       (get_local $v0)
        (i64.const 1)
        )
      )
    )

  ;; a[x]      ^= k[x];
  ;; a[x + 5]  ^= k[x];
  ;; a[x + 10] ^= k[x];
  ;; a[x + 15] ^= k[x];
  ;; a[x + 20] ^= k[x];

  ;; x = 0
  (i64.store (i32.add (get_local $ctx) (i32.const 0))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 0)))
      (get_local $k0)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 40))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 40)))
      (get_local $k0)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 80))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 80)))
      (get_local $k0)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 120))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 120)))
      (get_local $k0)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 160))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 160)))
      (get_local $k0)
    )
  )

  ;; x = 1
  (i64.store (i32.add (get_local $ctx) (i32.const 8))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 8)))
      (get_local $k1)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 48))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 48)))
      (get_local $k1)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 88))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 88)))
      (get_local $k1)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 128))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 128)))
      (get_local $k1)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 168))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 168)))
      (get_local $k1)
    )
  )

  ;; x = 2
  (i64.store (i32.add (get_local $ctx) (i32.const 16))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 16)))
      (get_local $k2)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 56))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 56)))
      (get_local $k2)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 96))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 96)))
      (get_local $k2)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 136))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 136)))
      (get_local $k2)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 176))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 176)))
      (get_local $k2)
    )
  )

  ;; x = 3
  (i64.store (i32.add (get_local $ctx) (i32.const 24))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 24)))
      (get_local $k3)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 64))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 64)))
      (get_local $k3)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 104))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 104)))
      (get_local $k3)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 144))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 144)))
      (get_local $k3)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 184))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 184)))
      (get_local $k3)
    )
  )

  ;; x = 4
  (i64.store (i32.add (get_local $ctx) (i32.const 32))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 32)))
      (get_local $k4)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 72))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 72)))
      (get_local $k4)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 112))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 112)))
      (get_local $k4)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 152))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 152)))
      (get_local $k4)
    )
  )

  (i64.store (i32.add (get_local $ctx) (i32.const 192))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 192)))
      (get_local $k4)
    )
  )
)

(func $keccak_rho (export "keccak_rho") (param $ctx i32) (param $rotation_consts i32)

  ;;(local $tmp i32)

  ;; state[ 1] = ROTL64(state[ 1],  1);
  ;;(set_local $tmp (i32.add (get_local $ctx) (i32.const 1)))
  ;;(i64.store (get_local $tmp) (i64.rotl (i64.load (get_local $ctx)) (i64.const 1)))

  ;;(set_local $tmp (i32.add (get_local $ctx) (i32.const 2)))
  ;;(i64.store (get_local $tmp) (i64.rotl (i64.load (get_local $ctx)) (i64.const 62)))

  (local $tmp i32)
  (local $i i32)

  ;; for (i = 0; i <= 24; i++)
  (set_local $i (i32.const 0))
  (loop $done $loop
    (if (i32.ge_u (get_local $i) (i32.const 24))
      (br $done)
    )

    (set_local $tmp (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (i32.const 1) (get_local $i)))))

    (i64.store (get_local $tmp) (i64.rotl (i64.load (get_local $tmp)) (i64.load8_u (i32.add (get_local $rotation_consts) (get_local $i)))))

    (set_local $i (i32.add (get_local $i) (i32.const 1)))
    (br $loop)
  )
)

(func $keccak_pi (export "keccak_pi") (param $ctx i32)
  (local $a1 i64)
  (set_local $a1 (i64.load (i32.add (get_local $ctx) (i32.const 8))))

  ;; Swap non-overlapping fields, i.e. $a1 = $a6, etc.
  ;; NOTE: $a0 is untouched
  (i64.store (i32.add (get_local $ctx) (i32.const 8)) (i64.load (i32.add (get_local $ctx) (i32.const 48))))
  (i64.store (i32.add (get_local $ctx) (i32.const 48)) (i64.load (i32.add (get_local $ctx) (i32.const 72))))
  (i64.store (i32.add (get_local $ctx) (i32.const 72)) (i64.load (i32.add (get_local $ctx) (i32.const 176))))
  (i64.store (i32.add (get_local $ctx) (i32.const 176)) (i64.load (i32.add (get_local $ctx) (i32.const 112))))
  (i64.store (i32.add (get_local $ctx) (i32.const 112)) (i64.load (i32.add (get_local $ctx) (i32.const 160))))
  (i64.store (i32.add (get_local $ctx) (i32.const 160)) (i64.load (i32.add (get_local $ctx) (i32.const 16))))
  (i64.store (i32.add (get_local $ctx) (i32.const 16)) (i64.load (i32.add (get_local $ctx) (i32.const 96))))
  (i64.store (i32.add (get_local $ctx) (i32.const 96)) (i64.load (i32.add (get_local $ctx) (i32.const 104))))
  (i64.store (i32.add (get_local $ctx) (i32.const 104)) (i64.load (i32.add (get_local $ctx) (i32.const 152))))
  (i64.store (i32.add (get_local $ctx) (i32.const 152)) (i64.load (i32.add (get_local $ctx) (i32.const 184))))
  (i64.store (i32.add (get_local $ctx) (i32.const 184)) (i64.load (i32.add (get_local $ctx) (i32.const 120))))
  (i64.store (i32.add (get_local $ctx) (i32.const 120)) (i64.load (i32.add (get_local $ctx) (i32.const 32))))
  (i64.store (i32.add (get_local $ctx) (i32.const 32)) (i64.load (i32.add (get_local $ctx) (i32.const 192))))
  (i64.store (i32.add (get_local $ctx) (i32.const 192)) (i64.load (i32.add (get_local $ctx) (i32.const 168))))
  (i64.store (i32.add (get_local $ctx) (i32.const 168)) (i64.load (i32.add (get_local $ctx) (i32.const 64))))
  (i64.store (i32.add (get_local $ctx) (i32.const 64)) (i64.load (i32.add (get_local $ctx) (i32.const 128))))
  (i64.store (i32.add (get_local $ctx) (i32.const 128)) (i64.load (i32.add (get_local $ctx) (i32.const 40))))
  (i64.store (i32.add (get_local $ctx) (i32.const 40)) (i64.load (i32.add (get_local $ctx) (i32.const 24))))
  (i64.store (i32.add (get_local $ctx) (i32.const 24)) (i64.load (i32.add (get_local $ctx) (i32.const 144))))
  (i64.store (i32.add (get_local $ctx) (i32.const 144)) (i64.load (i32.add (get_local $ctx) (i32.const 136))))
  (i64.store (i32.add (get_local $ctx) (i32.const 136)) (i64.load (i32.add (get_local $ctx) (i32.const 88))))
  (i64.store (i32.add (get_local $ctx) (i32.const 88)) (i64.load (i32.add (get_local $ctx) (i32.const 56))))
  (i64.store (i32.add (get_local $ctx) (i32.const 56)) (i64.load (i32.add (get_local $ctx) (i32.const 80))))

  ;; Place the previously saved overlapping field
  (i64.store (i32.add (get_local $ctx) (i32.const 80)) (get_local $a1))
)

(func $keccak_chi (export "keccak_chi") (param $ctx i32)
  (local $a0 i64)
  (local $a1 i64)
  (local $i i32)

  ;; for (round = 0; round < 25; i += 5)
  (set_local $i (i32.const 0))
  (loop $done $loop
    (if (i32.ge_u (get_local $i) (i32.const 25))
      (br $done)
    )

    (set_local $a0 (i64.load (i32.add (get_local $ctx) (i32.mul (i32.const 8) (get_local $i)))))
    (set_local $a1 (i64.load (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (get_local $i) (i32.const 1))))))

    ;; a[0 + i] ^= ~a1 & a[2 + i];
    (i64.store (i32.add (get_local $ctx) (i32.mul (i32.const 8) (get_local $i)))
      (i64.xor
        (i64.load (i32.add (get_local $ctx) (i32.mul (i32.const 8) (get_local $i))))
        (i64.and
          (i64.xor (get_local $a1) (i64.const 0xFFFFFFFFFFFFFFFF)) ;; bitwise not
          (i64.load (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (get_local $i) (i32.const 2)))))
        )
      )
    )

    ;; a[1 + i] ^= ~a[2 + i] & a[3 + i];
    (i64.store (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (get_local $i) (i32.const 1))))
      (i64.xor
        (i64.load (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (get_local $i) (i32.const 1)))))
        (i64.and
          (i64.xor (i64.load (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (get_local $i) (i32.const 2))))) (i64.const 0xFFFFFFFFFFFFFFFF)) ;; bitwise not
          (i64.load (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (get_local $i) (i32.const 3)))))
        )
      )
    )

    ;; a[2 + i] ^= ~a[3 + i] & a[4 + i];
    (i64.store (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (get_local $i) (i32.const 2))))
      (i64.xor
        (i64.load (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (get_local $i) (i32.const 2)))))
        (i64.and
          (i64.xor (i64.load (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (get_local $i) (i32.const 3))))) (i64.const 0xFFFFFFFFFFFFFFFF)) ;; bitwise not
          (i64.load (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (get_local $i) (i32.const 4)))))
        )
      )
    )

    ;; a[3 + i] ^= ~a[4 + i] & a0;
    (i64.store (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (get_local $i) (i32.const 3))))
      (i64.xor
        (i64.load (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (get_local $i) (i32.const 3)))))
        (i64.and
          (i64.xor (i64.load (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (get_local $i) (i32.const 4))))) (i64.const 0xFFFFFFFFFFFFFFFF)) ;; bitwise not
      (get_local $a0)
        )
      )
    )

    ;; a[4 + i] ^= ~a0 & a1;
    (i64.store (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (get_local $i) (i32.const 4))))
      (i64.xor
        (i64.load (i32.add (get_local $ctx) (i32.mul (i32.const 8) (i32.add (get_local $i) (i32.const 4)))))
        (i64.and
          (i64.xor (get_local $a0) (i64.const 0xFFFFFFFFFFFFFFFF)) ;; bitwise not
          (get_local $a1)
        )
      )
    )

    (set_local $i (i32.add (get_local $i) (i32.const 5)))
    (br $loop)
  )
)

(func $keccak_permute (export "keccak_permute")  (param $ctx i32)
  (local $rotation_consts i32)
  (local $round_consts i32)
  (local $round i32)

  (set_local $round_consts (i32.add (get_local $ctx) (i32.const 400)))
  (set_local $rotation_consts (i32.add (get_local $ctx) (i32.const 592)))

  ;; for (round = 0; round < 24; round++)
  (set_local $round (i32.const 0))
  (loop $done $loop
    (if (i32.ge_u (get_local $round) (i32.const 24))
      (br $done)
    )

    ;; theta transform
    (call $keccak (get_local $ctx))

    ;; rho transform
    (call $keccak_rho (get_local $ctx) (get_local $rotation_consts))

    ;; pi transform
    (call $keccak_pi (get_local $ctx))

    ;; chi transform
    (call $keccak_chi (get_local $ctx))

    ;; iota transform
    ;; ctx[0] ^= KECCAK_ROUND_CONSTANTS[round];
    (i64.store (get_local $ctx)
      (i64.xor
        (i64.load (get_local $ctx))
        (i64.load (i32.add (get_local $round_consts) (i32.mul (i32.const 8) (get_local $round))))
      )
    )

    (set_local $round (i32.add (get_local $round) (i32.const 1)))
    (br $loop)
  )
)

(func $keccak_block (param $input i32) (param $input_length i32) (param $ctx i32)
  ;; read blocks in little-endian order and XOR against context or (ctx)

  (i64.store
    (i32.add (get_local $ctx) (i32.const 0))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 0)))
      (i64.load (i32.add (get_local $input) (i32.const 0)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 8))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 8)))
      (i64.load (i32.add (get_local $input) (i32.const 8)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 16))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 16)))
      (i64.load (i32.add (get_local $input) (i32.const 16)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 24))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 24)))
      (i64.load (i32.add (get_local $input) (i32.const 24)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 32))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 32)))
      (i64.load (i32.add (get_local $input) (i32.const 32)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 40))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 40)))
      (i64.load (i32.add (get_local $input) (i32.const 40)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 48))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 48)))
      (i64.load (i32.add (get_local $input) (i32.const 48)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 56))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 56)))
      (i64.load (i32.add (get_local $input) (i32.const 56)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 64))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 64)))
      (i64.load (i32.add (get_local $input) (i32.const 64)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 72))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 72)))
      (i64.load (i32.add (get_local $input) (i32.const 72)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 80))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 80)))
      (i64.load (i32.add (get_local $input) (i32.const 80)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 88))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 88)))
      (i64.load (i32.add (get_local $input) (i32.const 88)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 96))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 96)))
      (i64.load (i32.add (get_local $input) (i32.const 96)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 104))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 104)))
      (i64.load (i32.add (get_local $input) (i32.const 104)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 112))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 112)))
      (i64.load (i32.add (get_local $input) (i32.const 112)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 120))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 120)))
      (i64.load (i32.add (get_local $input) (i32.const 120)))
    )
  )

  (i64.store
    (i32.add (get_local $ctx) (i32.const 128))
    (i64.xor
      (i64.load (i32.add (get_local $ctx) (i32.const 128)))
      (i64.load (i32.add (get_local $input) (i32.const 128)))
    )
  )

  (call $keccak_permute (get_local $ctx))
)

;;
;; Initialise the context
;;
(func (export "keccak_init") (param $ctx i32)
  (local $round_consts i32)
  (local $rotation_consts i32)

  (call $keccak_reset (get_local $ctx))

  ;; insert the round constants (used by $KECCAK_IOTA)
  (set_local $round_consts (i32.add (get_local $ctx) (i32.const 400)))
  (i64.store (i32.add (get_local $round_consts) (i32.const 0)) (i64.const 0x0000000000000001))
  (i64.store (i32.add (get_local $round_consts) (i32.const 8)) (i64.const 0x0000000000008082))
  (i64.store (i32.add (get_local $round_consts) (i32.const 16)) (i64.const 0x800000000000808A))
  (i64.store (i32.add (get_local $round_consts) (i32.const 24)) (i64.const 0x8000000080008000))
  (i64.store (i32.add (get_local $round_consts) (i32.const 32)) (i64.const 0x000000000000808B))
  (i64.store (i32.add (get_local $round_consts) (i32.const 40)) (i64.const 0x0000000080000001))
  (i64.store (i32.add (get_local $round_consts) (i32.const 48)) (i64.const 0x8000000080008081))
  (i64.store (i32.add (get_local $round_consts) (i32.const 56)) (i64.const 0x8000000000008009))
  (i64.store (i32.add (get_local $round_consts) (i32.const 64)) (i64.const 0x000000000000008A))
  (i64.store (i32.add (get_local $round_consts) (i32.const 72)) (i64.const 0x0000000000000088))
  (i64.store (i32.add (get_local $round_consts) (i32.const 80)) (i64.const 0x0000000080008009))
  (i64.store (i32.add (get_local $round_consts) (i32.const 88)) (i64.const 0x000000008000000A))
  (i64.store (i32.add (get_local $round_consts) (i32.const 96)) (i64.const 0x000000008000808B))
  (i64.store (i32.add (get_local $round_consts) (i32.const 104)) (i64.const 0x800000000000008B))
  (i64.store (i32.add (get_local $round_consts) (i32.const 112)) (i64.const 0x8000000000008089))
  (i64.store (i32.add (get_local $round_consts) (i32.const 120)) (i64.const 0x8000000000008003))
  (i64.store (i32.add (get_local $round_consts) (i32.const 128)) (i64.const 0x8000000000008002))
  (i64.store (i32.add (get_local $round_consts) (i32.const 136)) (i64.const 0x8000000000000080))
  (i64.store (i32.add (get_local $round_consts) (i32.const 144)) (i64.const 0x000000000000800A))
  (i64.store (i32.add (get_local $round_consts) (i32.const 152)) (i64.const 0x800000008000000A))
  (i64.store (i32.add (get_local $round_consts) (i32.const 160)) (i64.const 0x8000000080008081))
  (i64.store (i32.add (get_local $round_consts) (i32.const 168)) (i64.const 0x8000000000008080))
  (i64.store (i32.add (get_local $round_consts) (i32.const 176)) (i64.const 0x0000000080000001))
  (i64.store (i32.add (get_local $round_consts) (i32.const 184)) (i64.const 0x8000000080008008))

  ;; insert the rotation constants (used by $keccak_rho)
  (set_local $rotation_consts (i32.add (get_local $ctx) (i32.const 592)))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 0)) (i32.const 1))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 1)) (i32.const 62))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 2)) (i32.const 28))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 3)) (i32.const 27))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 4)) (i32.const 36))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 5)) (i32.const 44))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 6)) (i32.const 6))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 7)) (i32.const 55))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 8)) (i32.const 20))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 9)) (i32.const 3))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 10)) (i32.const 10))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 11)) (i32.const 43))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 12)) (i32.const 25))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 13)) (i32.const 39))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 14)) (i32.const 41))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 15)) (i32.const 45))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 16)) (i32.const 15))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 17)) (i32.const 21))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 18)) (i32.const 8))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 19)) (i32.const 18))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 20)) (i32.const 2))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 21)) (i32.const 61))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 22)) (i32.const 56))
  (i32.store8 (i32.add (get_local $rotation_consts) (i32.const 23)) (i32.const 14))
)

;;
;; Reset the context
;;
(func $keccak_reset
  (param $ctx i32)

  ;; clear out the context memory
  (call $memset (get_local $ctx) (i32.const 0) (i32.const 400))
)

;;
;; Push input to the context
;;
(func (export "keccak_update") (param $ctx i32) (param $input i32) (param $input_length i32)
  (local $residue_offset i32)
  (local $residue_buffer i32)
  (local $residue_index i32)
  (local $tmp i32)

  ;; this is where we store the pointer
  (set_local $residue_offset (i32.add (get_local $ctx) (i32.const 200)))
  ;; this is where the buffer is
  (set_local $residue_buffer (i32.add (get_local $ctx) (i32.const 208)))

  (set_local $residue_index (i32.load (get_local $residue_offset)))

  ;; process residue from last block
  (if (i32.ne (get_local $residue_index) (i32.const 0))
    (then
      ;; the space left in the residue buffer
      (set_local $tmp (i32.sub (i32.const 136) (get_local $residue_index)))

      ;; limit to what we have as an input
      (if (i32.lt_u (get_local $input_length) (get_local $tmp))
        (set_local $tmp (get_local $input_length))
      )

      ;; fill up the residue buffer
      (call $memcpy
        (i32.add (get_local $residue_buffer) (get_local $residue_index))
        (get_local $input)
        (get_local $tmp)
      )

      (set_local $residue_index (i32.add (get_local $residue_index) (get_local $tmp)))

      ;; block complete
      (if (i32.eq (get_local $residue_index) (i32.const 136))
        (call $keccak_block (get_local $input) (i32.const 136) (get_local $ctx))

        (set_local $residue_index (i32.const 0))
      )

      (i32.store (get_local $residue_offset) (get_local $residue_index))

      (set_local $input_length (i32.sub (get_local $input_length) (get_local $tmp)))
    )
  )

  ;; while (input_length > block_size)
  (loop $done $loop
    (if (i32.lt_u (get_local $input_length) (i32.const 136))
      (br $done)
    )

    (call $keccak_block (get_local $input) (i32.const 136) (get_local $ctx))

    (set_local $input(i32.add (get_local $input) (i32.const 136)))
    (set_local $input_length (i32.sub (get_local $input_length) (i32.const 136)))
    (br $loop)
  )

  ;; copy to the residue buffer
  (if (i32.gt_u (get_local $input_length) (i32.const 0))
    (then
      (call $memcpy
        (i32.add (get_local $residue_buffer) (get_local $residue_index))
        (get_local $input)
        (get_local $input_length)
      )

      (set_local $residue_index (i32.add (get_local $residue_index) (get_local $input_length)))
      (i32.store (get_local $residue_offset) (get_local $residue_index))
    )
  )
)

;;
;; Finalise and return the hash
;;
;; The 256 bit hash is returned at the output offset.
;;
(func $keccak_finish
  (param $ctx i32)
  (param $output_offset i32)

  (local $residue_offset i32)
  (local $residue_buffer i32)
  (local $residue_index i32)
  (local $tmp i32)

  ;; this is where we store the pointer
  (set_local $residue_offset (i32.add (get_local $ctx) (i32.const 200)))
  ;; this is where the buffer is
  (set_local $residue_buffer (i32.add (get_local $ctx) (i32.const 208)))

  (set_local $residue_index (i32.load (get_local $residue_offset)))
  (set_local $tmp (get_local $residue_index))

  ;; clear the rest of the residue buffer
  (call $memset (i32.add (get_local $residue_buffer) (get_local $tmp)) (i32.const 0) (i32.sub (i32.const 136) (get_local $tmp)))

  ;; ((char*)ctx->message)[ctx->rest] |= 0x01;
  (set_local $tmp (i32.add (get_local $residue_buffer) (get_local $residue_index)))
  (i32.store8 (get_local $tmp) (i32.or (i32.load8_u (get_local $tmp)) (i32.const 0x01)))

  ;; ((char*)ctx->message)[block_size - 1] |= 0x80;
  (set_local $tmp (i32.add (get_local $residue_buffer) (i32.const 135)))
  (i32.store8 (get_local $tmp) (i32.or (i32.load8_u (get_local $tmp)) (i32.const 0x80)))

  (call $keccak_block (get_local $residue_buffer) (i32.const 136) (get_local $ctx))

  ;; the first 32 bytes pointed at by $output_offset is the final hash
  (i64.store (get_local $output_offset) (i64.load (get_local $ctx)))
  (i64.store (i32.add (get_local $output_offset) (i32.const 8)) (i64.load (i32.add (get_local $ctx) (i32.const 8))))
  (i64.store (i32.add (get_local $output_offset) (i32.const 16)) (i64.load (i32.add (get_local $ctx) (i32.const 16))))
  (i64.store (i32.add (get_local $output_offset) (i32.const 24)) (i64.load (i32.add (get_local $ctx) (i32.const 24))))
)

;;
;; Calculate the hash. Helper method incorporating the above three.
;;
(func $keccak_hash
  (param $ctx i32) (param $input i32)
  (param $input_length i32)
  (param $output_offset i32)

  (call $keccak_init (get_local $ctx))
  (call $keccak_update (get_local $ctx) (get_local $input) (get_local $input_length))
  (call $keccak_finish (get_local $ctx) (get_local $output_offset))
)
