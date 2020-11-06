//a

function factorialIteratively(n) {
    let acc = 1;
    for (let i = 1; i <= n; i++)
        acc *= i;
    return acc;
}

const funcRecursively = function (n) {
    const go = function (n, acc) {
        if (n <= 1) return acc;
        else return go(n - 1, acc * n);
    }
    return go(n, 1);
}

const fibonacci = function (n) {
    const go = function (n, previous, current) {
        if (n === 0) return 0;
        else if (n === 1) return current;
        else return go(n - 1, current, (previous + current));
    }
    return go(n, 0, 1);
}

const isPalindrome = function (string) {
    const halfOfLength = Math.floor(string.length / 2);
    const go = function (currentIndex) {
        if (currentIndex === halfOfLength) return true;
        else {
            const isTheSame = string.charAt(currentIndex) === string.charAt(string.length - currentIndex - 1);
            if (isTheSame) return go(currentIndex + 1);
            else return false;
        }

    }
    return go(0);
}

const alphabetically = string => string.split('').sort().join('');

const longestWord = function(string){
    const words = string.split(' ');
    const go = function(longest,index){
        if(index === words.length -1) return longest;
        else if(words[index].length > longest.length) return go(words[index],index+1);
        else return go(longest,index+1);
    }
    return go(words[0],0);
}

const isPrime = function(number) {
    const abs = Math.abs(number);
    if(abs <= 1){
        console.log("you passed 0 or 1, those are not valid values");
        return false;
    }
    const sqrt = Math.floor(Math.sqrt(number));
    const go = function(currentDivisor){
        if(currentDivisor > sqrt) return true;
        else {
            const isDivisible = abs % currentDivisor === 0;
            if(isDivisible) return false;
            else return go(currentDivisor+1);
        }
    }
    return go(2);
}

const getType = value => typeof value;

const secondSmallestAndLargest = function(array){
    const twoElements = withIndices(array.sort()).filter(pair => pair[0] === 1 || pair[0] === array.length -2);
    return twoElements.map(pair => pair[1]);
}

const withIndices = function(array){
    const go = function (acc,index) {
        if(index === array.length-1)return  acc;
        else{
            acc.push([index,array[index]]);
            return go(acc,index+1);
        }
    }
    return go([],0);
}

const coins = [1,2,5,10,25,50];
const amountToCoins = function (amount,coins) {
    const coinsFromGreatest = coins.sort((a,b) => b -a);
    const go = function(amountLeft,acc) {
        if(amountLeft === 0) return acc;
        else {
            const biggestCoin = coinsFromGreatest.find(elem => elem <=amountLeft);
            acc.push(biggestCoin);
            return go(amountLeft - biggestCoin,acc);
        }
    }
    return go(amount,[]);
}



const binarySearch = function(array,key){
    const go = function(left,right) {
        if (left > right) return -1;
        else {
            const middle = Math.floor((left + right) / 2);
            if (array[middle] === key) return middle;
            else if (array[middle] > key) return go(left, middle-1);
            else return go(middle+1, right);
        }
    }
    return go(0,array.length-1);
}



console.log(getType(new Number(34)))  //object
console.log(amountToCoins(46,coins));
console.log(binarySearch([1,2,3,5,5,6,11,15,19,100],19))
console.log(secondSmallestAndLargest([5,2,5,1,8,9,5,5,6]));
console.log(isPrime(7919) + " isPrime");
console.log(longestWord("Some pretty long sentence aaa"));
console.log(alphabetically("webmaster"));
console.log(isPalindrome("aab") + " isPalindrome");
console.log(fibonacci(11));
console.log(funcRecursively(5));
console.log(factorialIteratively(5));