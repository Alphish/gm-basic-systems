str1 = OwnBinding.create(3);
str2 = OwnBinding.create(3);
str3 = OwnBinding.create(3);
str_total = CompositeBinding.create(function(_input) {
    return _input[0] + _input[1] + _input[2];
}, [str1, str2, str3]);
str_flag = CompositeBinding.create(function(_input) {
    return _input >= 15;
}, str_total);

agi1 = OwnBinding.create(3);
agi2 = OwnBinding.create(3);
agi3 = OwnBinding.create(3);
agi_total = CompositeBinding.create(function(_input) {
    return _input[0] + _input[1] + _input[2];
}, [agi1, agi2, agi3]);

int1 = OwnBinding.create(3);
int2 = OwnBinding.create(3);
int3 = OwnBinding.create(3);
int_total = CompositeBinding.create(function(_input) {
    return _input[0] + _input[1] + _input[2];
}, [int1, int2, int3]);

overall_total = CompositeBinding.create(function(_input) {
    return _input[0] + _input[1] + _input[2];
}, [str_total, agi_total, int_total]);

summary = DescriptionBinding.from_args(
    "Strength: {0}, Agility: {1}, Intellect: {2}, Overall: {3}",
    str_total, agi_total, int_total, overall_total
    );

summary_color = CompositeBinding.create(function(_input) {
    if (_input < 20)
        return c_red;
    else if (_input < 40)
        return c_yellow;
    else
        return c_lime;
}, overall_total);
