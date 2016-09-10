#include <cstdio>
#include <iostream>
#include <sstream>
#include <set>
#include "ast.h"

const char *temps[] = {"$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", "$t8", "$t9"};
#define TEMP_COUNT (sizeof(temps)/sizeof(temps[0]))

set<string> tempRegSet;
set<string> var_set;

string newTemp()
{
    int i;
    
    for (i=0; i<TEMP_COUNT; i++) {
        if (tempRegSet.find(temps[i]) == tempRegSet.end()) {
            tempRegSet.insert(temps[i]);
            
            return string(temps[i]);
        }
    }
    
    return string("");
}

void releaseTemp(string temp)
{
	tempRegSet.erase(temp);
}

string LTExpr::generateCode(string &place)
{
	//TODO: Implement code generation for less than expression
	return string("");
}

string GTExpr::generateCode(string &place)
{
	//TODO: Implement code generation for greater than expression
	return string("");
}

string LTEExpr::generateCode(string &place)
{
	//TODO: Implement code generation for "less or equal to" expression
	return string("");
}

string GTEExpr::generateCode(string &place)
{
	//TODO: Implement code generation for "less or equal to" expression
	return string("");
}

string EQExpr::generateCode(string &place)
{
	//TODO: Implement code generation "equal to" expression
	return string("");
}

string NEExpr::generateCode(string &place)
{
	//TODO: Implement code generation for "noot equal to" expression
	return string("");
}

string AddExpr::generateCode(string &place)
{
    string place1, place2;
    string code1 = expr1->generateCode(place1);
    string code2 = expr2->generateCode(place2);
    stringstream ss;
    
    releaseTemp(place1);
    releaseTemp(place2);
    place = newTemp();
    
    ss << code1 << endl <<
          code2 << endl <<
          "add " << place << ", " << place1 << ", " << place2;
          
    return ss.str();
}

string SubExpr::generateCode(string &place)
{
    string place1, place2;
    string code1 = expr1->generateCode(place1);
    string code2 = expr2->generateCode(place2);
    stringstream ss;
    
    releaseTemp(place1);
    releaseTemp(place2);
    place = newTemp();
    
    ss << code1 << endl <<
    code2 << endl <<
    "sub " << place << ", " << place1 << ", " << place2;
    
    return ss.str();
}

string MultExpr::generateCode(string &place)
{
    string place1, place2;
    string code1 = expr1->generateCode(place1);
    string code2 = expr2->generateCode(place2);
    stringstream ss;
    
    releaseTemp(place1);
    releaseTemp(place2);
    place = newTemp();
    
    ss << code1 << endl <<
    code2 << endl <<
    "mult " << place1 << ", " << place2 << endl <<
    "mflo " << place;
    
    return ss.str();
}

string DivExpr::generateCode(string &place)
{
    string place1, place2;
    string code1 = expr1->generateCode(place1);
    string code2 = expr2->generateCode(place2);
    stringstream ss;
    
    releaseTemp(place1);
    releaseTemp(place2);
    place = newTemp();
    
    ss << code1 << endl <<
    code2 << endl <<
    "div " << place1 << ", " << place2 << endl <<
    "mflo " << place;
    
    return ss.str();
}

string ModExpr::generateCode(string &place)
{
	//TODO: Implement code generation for MOD
}

string NumExpr::generateCode(string &place)
{
    stringstream ss;
    
    place = newTemp();
    
    ss << "li " << place << ", " << value;
    
    return ss.str();
}

string IdExpr::generateCode(string &place)
{
    stringstream ss;
    
    place = newTemp();
    
    ss << "la " << place << ", " << id << endl
       << "lw " << place << ", 0(" << place << ")";
    
    return ss.str();
}

string StringExpr::generateCode(string &place)
{
	//TODO: Implement code generation for String expression
	return string("");
}

string BlockStatement::generateCode()
{
    list<Statement *>::iterator it = stList.begin();
    stringstream ss;
	
    while (it != stList.end()) {
        Statement *st = *it;
        
        ss << st->generateCode() << endl;
        it++;
    }   
	
	return ss.str();
}

string WritelnStatement::generateCode() 
{
	//TODO: Implement code generation for Writeln statement
	return string("");
}

string AssignStatement::generateCode()
{
    if (var_set.find(id) == var_set.end()) {
		var_set.insert(id);
    }
    
	string code, place, temp;
    stringstream ss;
	
	code = expr->generateCode(place);
	
	temp = newTemp();
	
	ss << code << endl
	   << "la " << temp << ", " << id << endl
	   << "sw " << place << ", 0(" << temp << ")";
	   
	releaseTemp(place);
	releaseTemp(temp);
	
	return ss.str();	
}

string IfStatement::generateCode() 
{
	//TODO: Implement code generation for "If" statement
	return string("");
}

string WhileStatement::generateCode()
{
	return string("");
}