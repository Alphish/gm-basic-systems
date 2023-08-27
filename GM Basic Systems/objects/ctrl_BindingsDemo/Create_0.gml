str1 = OwnBinding.create(3);
str2 = OwnBinding.create(3);
str3 = OwnBinding.create(3);
str_total = AggregateBinding.create(function (_input) {
    return _input[0] + _input[1] + _input[2];
}, [str1, str2, str3]);

agi1 = OwnBinding.create(3);
agi2 = OwnBinding.create(3);
agi3 = OwnBinding.create(3);
agi_total = AggregateBinding.create(function (_input) {
    return _input[0] + _input[1] + _input[2];
}, [agi1, agi2, agi3]);

int1 = OwnBinding.create(3);
int2 = OwnBinding.create(3);
int3 = OwnBinding.create(3);
int_total = AggregateBinding.create(function (_input) {
    return _input[0] + _input[1] + _input[2];
}, [int1, int2, int3]);

overall_total = AggregateBinding.create(function (_input) {
    return _input[0] + _input[1] + _input[2];
}, [str_total, agi_total, int_total]);

summary = DescriptionBinding.from_args(
    "Strength: {0}, Agility: {1}, Intellect: {2}, Overall: {3}",
    str_total, agi_total, int_total, overall_total
    );
