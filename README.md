# Simple-Engima-Cipher-SV-Verilog HDL
Customised simple verilog HDL implementation of Engima cipher


## Overview of the Enigma Machine

The Enigma machine consists of several components that work together to encrypt and decrypt messages:
Plugboard: Swaps pairs of letters before and after the rotor system.
Rotors: Apply a substitution (permutation) of the 26 letters, with positions that shift dynamically.
Reflector: Reflects the signal back through the rotors, applying a fixed, involutory permutation.

The signal path through the machine is: input → plugboard → rotors (forward) → reflector → rotors (inverse) → plugboard → output. This symmetric process allows the same machine configuration to both encrypt and decrypt messages.

### One-Hot Encoding
In this implementation, each letter of the A-Z alphabet is represented using one-hot encoding:

A = 000...001 (bit 0 = 1)
B = 000...010 (bit 1 = 1)
...
Z = 100...000 (bit 25 = 1)

This encoding scheme simplifies the implementation of permutations, as each operation can be modeled as a bit permutation, which is efficiently implementable in hardware.

## Verilog Implementation
The implementation consists of several Verilog modules:
Module Descriptions

### Plugboard:
Input: 26-bit one-hot vector
Output: 26-bit one-hot vector after permutation
Implemented using assign statements to hardwire the swaps.

### Rotor:
Inputs: 26-bit one-hot vector, 5-bit rotor position (0-25), direction (0 for forward, 1 for inverse)
Output: 26-bit one-hot vector after permutation
Implements the rotor's permutation, including shifts based on position.

### Reflector:
Input: 26-bit one-hot vector
Output: 26-bit one-hot vector after involutory permutation
Implemented similarly to the plugboard with pairwise swaps.

Usage
To use this Enigma machine emulation:
Set the rotor positions using the n1, n2, and n3 inputs (5-bit values representing positions 0 to 25).
Provide the input letter as a 26-bit one-hot encoded vector.
The output letter will be produced as a 26-bit one-hot encoded vector.

Eg:-
For a specific configuration:
Set rotor positions: n1 = 0, n2 = 0, n3 = 0
Input letter A: input_letter = 26'b000...001

The output will be the encrypted letter based on the machine's configuration.
