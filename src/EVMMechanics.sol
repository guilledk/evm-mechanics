// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EVMMechanics {
    // Event to print prime numbers is now removed since we're returning the last prime instead
    // event PrimeNumber(uint256 prime);

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Main function to simulate expensive read-only EVM operation
    // Modified to return the last prime number generated
    function roEvm(uint256 primeMax) public returns (uint256) {
        unchecked {
            require(msg.sender == owner, "Unauthorized");

            uint256 lastPrime = 0; // Variable to hold the last prime number found

            for (uint256 p = 2; p <= primeMax; p += 1) {
                if (isPrime(p) && isMersennePrime(p)) {
                    lastPrime = p; // Update lastPrime with the current prime
                }
            }

            // Instead of reverting, return the last prime number found
            return lastPrime;
        }
    }

    // Helper function to check if a number is prime
    function isPrime(uint256 p) private pure returns (bool) {
        unchecked {
            if (p == 2) {
                return true;
            } else if (p <= 1 || p % 2 == 0) {
                return false;
            }

            for (uint256 i = 3; i <= sqrt(p); i += 2) {
                if (p % i == 0) {
                    return false;
                }
            }
            return true;
        }
    }

    // Helper function to calculate square root
    function sqrt(uint256 x) private pure returns (uint256 y) {
        unchecked {
            uint256 z = (x + 1) / 2;
            y = x;
            while (z < y) {
                y = z;
                z = (x / z + z) / 2;
            }
        }
    }

    // Helper function to check if a number is a Mersenne prime
    function isMersennePrime(uint256 p) private pure returns (bool) {
        unchecked {
            if (p == 2) return true;
            uint256 mP = (2**p) - 1;
            uint256 s = 4;
            for (uint256 i = 3; i <= p; i++) {
                s = (s * s - 2) % mP;
            }
            return (s == 0);
        }
    }
}
