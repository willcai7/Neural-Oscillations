#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <iostream>
#include <fstream>
#include <sys/time.h>
#include <cstdlib>
#include <float.h>
#include <random>
#include <stdint.h>
#include <algorithm>
#include <cstdio>
#include <climits>
#include <vector>

#define _USE_MATH_DEFINES
using namespace std;

int NE = 75;
int NI = 25;
int Level = 100;//membrane potential
double PEE = 0.15;//probability of postsynaptic connections
double PIE = 0.5;
double PEI = 0.5;
double PII = 0.4;
double SEE = 20;//strength of postsynaptic connection
double SIE = 8;
double SEI = -20;
double SII = -20;
double kickE = 7000.0;//external drive rate
double kickI = 7000.0;
//double Ref = 250.0;//time rate at state R
double HitEE = 1000.0/1.4;//delay time rate
double HitIE = 1000.0/1.2;
double HitI = 1000.0/4.5;//
int Reverse = -66;//reverse potential
int E_spike = 0;
int I_spike = 0;


int real2int(const double x, mt19937& mt, uniform_real_distribution<double>& u)
//choose a random integer n if x is not an integer, such that the expectation of n is equal to x
{
    int xf = floor(x);
    double q = x - (double)xf;
    double y = 0;
    if( u(mt) < q)
        y = xf + 1;
    else
        y = xf;
    return y;
}

template <class T>
class Vector : public vector<T> {
private:
    T sum;
public:
    
    double get_sum()
    {
        return sum;
    }
    
    void maintain()
    {
        T tmp_sum = 0;
        for(auto && it : (*this))
            tmp_sum += it;
 //       cout<<tmp_sum<<endl;
        sum = tmp_sum;
    }
    
    void switch_element(const int index, T element)
    //switch [index] by element and maintain sum
    {
        sum = sum - (*this)[index] + element;
        (*this)[index] = element;
    }
    //The first three function is only for Clock[]
    
    bool remove_elt(unsigned index)
    //remove element [index]
    {
        if(this -> empty() || index < 0 || index >= this -> size()) {
            cout<<"Empty vector"<<endl;
            return false;
        }
        if(index == this->size() - 1) {
            this->pop_back();
        }
        else {
            T elt = (*this)[(*this).size() - 1];
            (*this)[index] = elt;
            (*this).pop_back();
        }
        return true;
    }
    
    int select(mt19937& mt, uniform_real_distribution<double>& u)
    {
        if( this->size() == 0)
        {
            cout<<"Size cannot be zero "<<endl;
            return -1;
        }
        else
        {
            int index = floor(u(mt)*this->size());
            T tmp =  (*this)[index];
            remove_elt(index);
            return tmp;
        }
    }
    
    int find_min() {
        if(!this -> empty()) {
            auto min = (*this)[0];
            auto index = 0;
            auto iter = 0;
            for(auto&& item : (*this)) {
                if(item < min) {
                    min = item;
                    index = iter;
                }
                iter++;
            }
            return index;
        }
        return -1;
    }
    
    void print_vector() {
        for(auto && it : (*this)) {
            cout<<it<<" ";
        }
        cout<<endl;
    }
    
};


bool compare(int num)
{
    return num>=45;
}
int find_index(Vector<double>& array, mt19937& mt, uniform_real_distribution<double>& u)
//find a random element in a positive array. The probability of chosen is proportional to the value.
{
    double sum = array.get_sum();
    double tmp = u(mt);
    int index = 0;
    int size = array.size();
    double tmp_double = array[0]/sum;
//    cout<<tmp_double<<" "<<tmp<<endl;
    while(tmp_double < tmp && index < size - 1)
    {
        index++;
        tmp_double+=array[index]/sum;
    }
    return index;
}

void spikeE(const int whichHit, Vector<double>& Clock, vector<int> &VE, Vector<int> &HEE, Vector<int> &HIE, Vector<int> &Eref, vector<int> &awakeE, vector<int> &awakeI, mt19937& mt, uniform_real_distribution<double>& u)
{
    E_spike ++;
    VE[whichHit] = 0;
//    awakeE[whichHit] = 0;
//    Eref.push_back(whichHit);
//    Clock.switch_element(6, Ref*Eref.size());
    for(int i = 0; i < NE; i++)
    {
        if(u(mt) < PEE && awakeE[i])
        {
            HEE.push_back(i);
        }
    }
    for(int i = 0; i < NI; i++)
    {
        if(u(mt) < PIE && awakeI[i])
        {
            HIE.push_back(i);
        }
    }
    Clock.switch_element(2, HitEE*HEE.size());
    Clock.switch_element(3, HitIE*HIE.size());
    
}
void spikeI(const int whichHit, Vector<double>& Clock, vector<int> &VI, Vector<int> &HEI, Vector<int> &HII, Vector<int> &Iref, vector<int> &awakeE, vector<int> &awakeI, mt19937& mt, uniform_real_distribution<double>& u)
{
    I_spike ++;
    VI[whichHit] = 0;
//    awakeI[whichHit] = 0;
//    Iref.push_back(whichHit);
//    Clock.switch_element(7, Ref*Iref.size());
    for(int i = 0; i < NE; i++)
    {
        if(u(mt) < PEI && awakeE[i])
        {
            HEI.push_back(i);
        }
    }
    for(int i = 0; i < NI; i++)
    {
        if(u(mt) < PII && awakeI[i])
        {
            HII.push_back(i);
        }
    }
    Clock.switch_element(4, HitI*HEI.size());
    Clock.switch_element(5, HitI*HII.size());
}

void update(vector<double>& time_spike, vector<int>& num_spike, vector<double>& record_time_point, vector<int>& N_GE, vector<int>& N_GI, vector<int>& total_HE,
            vector<int>& total_HI, Vector<double>& Clock, vector<int> &VE, vector<int> &VI, Vector<int> &HEE, Vector<int> &HEI,
            Vector<int> &HIE, Vector<int> &HII, Vector<int> &Eref, Vector<int> &Iref, vector<int> &awakeE, vector<int> &awakeI,
            const double terminate_time, mt19937& mt, uniform_real_distribution<double>& u)
{
    double current_time = 0.0;
    double record_time = 0.0;
    int count = 0;
    while(current_time < terminate_time)
    {
        if (current_time - record_time >0.0002)
        {
            record_time = current_time;
            record_time_point.push_back(current_time);
            total_HI.push_back(HII.size() + HEI.size());
            total_HE.push_back(HEE.size() + HIE.size());
            N_GE.push_back(count_if(VE.begin(), VE.end(), compare));
            N_GI.push_back(count_if(VI.begin(), VI.end(), compare));
        }
        current_time += -log(1 - u(mt))/Clock.get_sum();
        int index = find_index(Clock, mt, u);
        int whichHit;
        count ++;
        int local_index;
//            cout<<"time "<<current_time <<" index "<<index<<endl;
        switch (index)
        {
            case 0:
                whichHit = floor(u(mt)*NE);
                if(awakeE[whichHit])
                {
                    VE[whichHit]++;
                    if(VE[whichHit] >= Level)
                    {
                        spikeE(whichHit, Clock, VE, HEE, HIE, Eref, awakeE, awakeI, mt, u);
                        time_spike.push_back(current_time);
                        num_spike.push_back(whichHit);
                    }
                }
                break;
            case 1:
                whichHit = floor(u(mt)*NI);
                if(awakeI[whichHit])
                {
                    VI[whichHit]++;
                    if(VI[whichHit]>= Level)
                    {
                        spikeI(whichHit, Clock, VI, HEI, HII, Iref, awakeE, awakeI, mt, u);
                        time_spike.push_back(current_time);
                        num_spike.push_back(whichHit + NE);
                    }
                }
                break;
            case 2:
                whichHit = HEE.select(mt, u);
//                cout<<"ID = "<<whichHit<<" V = "<<VE[whichHit]<<endl<<" status = "<<awakeE[whichHit]<<endl;
                if(awakeE[whichHit])
                {

                    VE[whichHit] += real2int(SEE, mt, u);
                    if( VE[whichHit] >= Level)
                    {
                        spikeE(whichHit, Clock, VE, HEE, HIE, Eref, awakeE, awakeI, mt, u);
                        time_spike.push_back(current_time);
                        num_spike.push_back(whichHit);
                    }
                }
//                cout<<" after "<<VE[whichHit]<<endl;
                Clock.switch_element(2, HitEE*HEE.size());
                break;
            case 3:
                whichHit = HIE.select(mt, u);
//                cout<<HEE.size()<<endl;
                if(awakeI[whichHit])
                {
                    VI[whichHit] += real2int(SIE, mt, u);
                    if( VI[whichHit] >= Level)
                    {
                        spikeI(whichHit, Clock, VI, HEI, HII, Iref, awakeE, awakeI, mt, u);
                        time_spike.push_back(current_time);
                        num_spike.push_back(whichHit + NE);
                    }
                }
                Clock.switch_element(3, HitIE*HIE.size());
                break;
            case 4:
                whichHit = HEI.select(mt, u);
                if(awakeE[whichHit])
                {
                    VE[whichHit] += real2int(SEI * (VE[whichHit]-Reverse)/(Level - Reverse), mt, u);
                    if(VE[whichHit] < Reverse)
                        VE[whichHit] = Reverse;
                }
                Clock.switch_element(4, HitI*HEI.size());
                break;
            case 5:
                whichHit = HII.select(mt, u);
                if(awakeI[whichHit])
                {
                    VI[whichHit] += real2int(SII * (VI[whichHit]-Reverse)/(Level - Reverse), mt, u);
                    if(VE[whichHit] < Reverse)
                        VE[whichHit] = Reverse;
                }
                Clock.switch_element(5, HitI*HII.size());
                break;
//            case 6:
//                whichHit = Eref.select(mt, u);
//                awakeE[whichHit] = 1;
//                Clock.switch_element(6, Ref*Eref.size());
//                break;
//            case 7:
//                whichHit = Iref.select(mt, u);
//                awakeI[whichHit] = 1;
//                Clock.switch_element(7, Ref*Iref.size());
//                break;
        }
    }
}

int main()
{
    struct timeval t1, t2;
    gettimeofday(&t1,NULL);
    ofstream myfile;
    random_device rd;
    mt19937 mt(rd());
    uniform_real_distribution<double> u(0, 1);
    myfile.open("spike_info.txt");
    vector<int> VE(NE);//membrane potential
    vector<int> VI(NI);
    for(auto i : VE)
        i = 0;
    for(auto i : VI)
        i = 0;
    Vector<int> HEE, HEI, HII, HIE, Eref, Iref;
    //HEE, HEI ... pending postsynaptic kick
    //Eref, Iref: indices of neurons at state R
    HEE.reserve(100000);
    HEI.reserve(100000);
    HII.reserve(100000);
    HIE.reserve(100000);
    Eref.reserve(NE);
    Iref.reserve(NI);
    vector<int> awakeE(NE);
    for(auto & i : awakeE)
        i = 1;
    vector<int> awakeI(NI);
    for(auto & i : awakeI)
        i = 1;
    Vector<double> Clock;
    Clock.reserve(6);
    // 0 Edrive, 1 Idrive, 2 HEE, 3, HEI, 4, HIE, 5, HII
//    Clock.reserve(8);
    //0 Edrive, 1 Idrive, 2 HEE, 3, HEI, 4, HIE, 5, HII, 6, Eref, 7, Iref
    Clock.push_back(NE*kickE);
    Clock.push_back(NI*kickI);
    for(int i = 2; i < 6; i++)
        Clock.push_back(0);
    Clock.maintain();
    double terminate_time = 50.0;
    vector<double> time_spike;
    time_spike.reserve(100000);
    vector<int> num_spike;
    num_spike.reserve(100000);
    vector<double> record_time_point;
    record_time_point.reserve(250000);
    vector<int> N_GE;
    N_GE.reserve(250000);
    vector<int> N_GI;
    N_GI.reserve(250000);
    vector<int> total_HE;
    total_HE.reserve(250000);
    vector<int> total_HI;
    total_HI.reserve(250000);
    update(time_spike, num_spike, record_time_point, N_GE, N_GI, total_HE, total_HI, Clock, VE, VI, HEE, HEI, HIE, HII, Eref, Iref, awakeE,awakeI, terminate_time, mt, u);

    cout<<"E spike rate= "<<(double)E_spike/(terminate_time*NE)<<endl;
    cout<<"I spike rate = "<<(double)I_spike/(terminate_time*NI)<<endl;
    int spike_count = time_spike.size();
    for(int i = 0; i < spike_count; i++)
    {
        myfile<<time_spike[i]<<"  "<<num_spike[i]<<endl;
    }
    myfile.close();
    myfile.open("trajectory_info.txt");
    for(int i = 0; i < total_HI.size(); i++)
    {
        myfile<<record_time_point[i]<<" "<<N_GE[i]<<" "<<N_GI[i]<<" "<<total_HE[i]<<" "<<total_HI[i]<<endl;
    }

    
    gettimeofday(&t2, NULL);
    double delta = ((t2.tv_sec  - t1.tv_sec) * 1000000u +
                    t2.tv_usec - t1.tv_usec) / 1.e6;
    
    cout << "total CPU time = " << delta <<endl;
    
}







