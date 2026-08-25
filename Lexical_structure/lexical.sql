/*
Lexical Structure: 
PostgreSQL Lexical Structure — Quick Reference

Lexical structure is the basic rules for how SQL statements are written and parsed.

Core Concepts
Component	Description	Example
Token	Smallest meaningful unit	SELECT, 42, 'hello', ;
Keyword	Reserved words	SELECT, FROM, WHERE, UPDATE
Identifier	Names you define	table names, column names
Constant	Literal values	'text', 123, 3.14, true
Operator	Arithmetic/logical symbols	+, -, *, /, =, >, AND, OR
Identifiers
Start with letter or _, followed by letters, digits, _, or $
Max length: 63 bytes (default)
Unquoted: case-insensitive (name = NAME)
Quoted with ": case-sensitive, allows spaces and special chars ("User Email")
Constants
sql
-- Strings
'text'              -- Single quotes (escape ' with '')
E'path\n'           -- C-style escapes
$$no escaping$$     -- Dollar quoting
U&'Hello\0041'      -- Unicode escapes

-- Numbers
42, -10             -- Integers
3.14, .5, 5e2       -- Decimals with exponents
0xFF, 0o77, 0b1010  -- Hex, octal, binary

-- Bits
B'1010', X'FF'      -- Binary and hexadecimal
Operators & Precedence

Operators have priority (highest to lowest):

:: (typecast) > [] (array) > ^ (power) > * / % > + - > 
  = < > (comparison) > AND > OR

Use parentheses to override: (5 + 3) * 2

Special Characters
Char	Use
;	Ends command
--	Single-line comment
/* */	Block comment (nests)
()	Grouping
[]	Array subscript
.	Decimal point / name separator
,	List separator
$	Parameter in functions
Quick Rules

✓ Whitespace separates tokens (unless obvious from context)
✓ Multiple commands end with ;
✓ Comments are treated as whitespace
✓ Unquoted names → lowercase automatically
✓ Quoted names → preserve case
✓ Underscores in numbers are ignored: 1_000_000 = 1000000
*/