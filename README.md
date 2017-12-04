## Keccak (pre-standard SHA3) in WebAssembly

# Parameters:
- context /ctx (i32) -> 616 bytes of context
- input (i32)
- input length (i32)
- output offset (i32) -> 32 byte hash

# Context:

The context is laid out as follows:
- 0: 1600 bits - 200 bytes - hashing state
- 200:   64 bits -   8 bytes - residue position
- 208: 1536 bits - 192 bytes - residue buffer
- 400: 1536 bits - 192 bytes - round constants
- 592:  192 bits -  24 bytes - rotation constants




