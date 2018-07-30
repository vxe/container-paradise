#include <iostream>
#include <map>
#include <iterator>

using namespace std;

int main()
{
    map <int, int> key_value_store;        // empty map container

    // insert elements in random order
    key_value_store.insert(pair <int, int> (1, 40));
    key_value_store.insert(pair <int, int> (2, 30));
    key_value_store.insert(pair <int, int> (3, 60));
    key_value_store.insert(pair <int, int> (4, 20));
    key_value_store.insert(pair <int, int> (5, 50));
    key_value_store.insert(pair <int, int> (6, 50)); 
    key_value_store.insert(pair <int, int> (7, 10));

    // printing map key_value_store
    map <int, int> :: iterator itr;
    cout << "\nThe map key_value_store is : \n";
    cout << "\tKEY\tELEMENT\n";
    for (itr = key_value_store.begin(); itr != key_value_store.end(); ++itr)
    {
        cout  <<  '\t' << itr->first 
              <<  '\t' << itr->second << '\n';
    }
    cout << endl;

    // assigning the elements from key_value_store to gquiz2
    map <int, int> gquiz2(key_value_store.begin(), key_value_store.end());

    // print all elements of the map gquiz2
    cout << "\nThe map gquiz2 after assign from key_value_store is : \n";
    cout << "\tKEY\tELEMENT\n";
    for (itr = gquiz2.begin(); itr != gquiz2.end(); ++itr)
    {
        cout  <<  '\t' << itr->first 
              <<  '\t' << itr->second << '\n';
    }
    cout << endl;

    // remove all elements up to element with key=3 in gquiz2
    cout << "\ngquiz2 after removal of elements less than key=3 : \n";
    cout << "\tKEY\tELEMENT\n";
    gquiz2.erase(gquiz2.begin(), gquiz2.find(3));
    for (itr = gquiz2.begin(); itr != gquiz2.end(); ++itr)
    {
        cout  <<  '\t' << itr->first 
              <<  '\t' << itr->second << '\n';
    }

    // remove all elements with key = 4
    int num;
    num = gquiz2.erase (4);
    cout << "\ngquiz2.erase(4) : ";
    cout << num << " removed \n" ;
    cout << "\tKEY\tELEMENT\n";
    for (itr = gquiz2.begin(); itr != gquiz2.end(); ++itr)
    {
        cout  <<  '\t' << itr->first 
              <<  '\t' << itr->second << '\n';
    }

    cout << endl;

    //lower bound and upper bound for map key_value_store key = 5
    cout << "key_value_store.lower_bound(5) : " << "\tKEY = ";
    cout << key_value_store.lower_bound(5)->first << '\t';
    cout << "\tELEMENT = " << key_value_store.lower_bound(5)->second << endl;
    cout << "key_value_store.upper_bound(5) : " << "\tKEY = ";
    cout << key_value_store.upper_bound(5)->first << '\t';
    cout << "\tELEMENT = " << key_value_store.upper_bound(5)->second << endl;

    return 0;

}
