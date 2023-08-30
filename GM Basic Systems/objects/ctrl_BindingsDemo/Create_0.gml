str1 = OwnBinding.create(3);
str2 = OwnBinding.create(3);
str3 = OwnBinding.create(3);
str_total = CompositeBinding.create([str1, str2, str3], function(_input) {
    return _input[0] + _input[1] + _input[2];
});
str_flag = MapBinding.create(str_total, function(_input) {
    return _input >= 15;
});

agi1 = OwnBinding.create(3);
agi2 = OwnBinding.create(3);
agi3 = OwnBinding.create(3);
agi_total = CompositeBinding.create([agi1, agi2, agi3], function(_input) {
    return _input[0] + _input[1] + _input[2];
});
agi_tier = MapBinding.create(agi_total, function(_input) {
    return ceil(_input / 6);
});

int1 = OwnBinding.create(3);
int2 = OwnBinding.create(3);
int3 = OwnBinding.create(3);
int_total = CompositeBinding.create([int1, int2, int3], function(_input) {
    return _input[0] + _input[1] + _input[2];
});

overall_total = CompositeBinding.create([str_total, agi_total, int_total], function(_input) {
    return _input[0] + _input[1] + _input[2];
});

summary = DescriptionBinding.from_args(
    "Strength: {0}, Agility: {1}, Intellect: {2}, Overall: {3}",
    str_total, agi_total, int_total, overall_total
    );

summary_color = MapBinding.create(overall_total, function(_input) {
    if (_input < 20)
        return c_red;
    else if (_input < 40)
        return c_yellow;
    else
        return c_lime;
});
