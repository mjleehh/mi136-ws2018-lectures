template<typename T, int N>
struct Array {

    template<int i>
    T get() {
        static_cast(i < N, "out of bounds");
        return data_[i];
    }

    template<int i>
    void set(T value) {
        static_cast(i < N, "out of bounds");
        data_[i] = value;
    }

private:
    T data_[N];
};


int main() {
    Array<int, 12> arr;

    arr.set<3>(45);
    arr.get<14>();
}