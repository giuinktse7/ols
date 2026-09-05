package align_single_line_switch

Sizing_Kind :: enum {
    Fit,
    Grow,
    Fixed,
    Percent,
    Very_Long_Name,
}

Sizing :: struct {
    kind:  Sizing_Kind,
    value: f32,
}

size_value :: proc(size: Sizing) -> f32 {
    switch size.kind {
    case .Fit:     return 1
    case .Grow:    return 2
    case .Fixed:   return size.value
    case .Percent: return size.value / 100
    }
}

alignment_boundaries :: proc(size: Sizing) -> string {
    switch size.kind {
    case .Fit:            return "fit"
    case .Very_Long_Name: return "long"

    case .Grow: return "grow"
    case .Fixed: return "fixed" // A comment prevents this case from joining either group.
    case .Percent: return "percent"
    case:
        if size.value > 0 {
            return "positive"
        }
    case .Fit:  return "fit again"
    case .Grow: return "grow again"
    }
}

alignment_respects_width :: proc(size: Sizing) -> string {
    switch size.kind {
    case .Fit:
        return "123456789012345678901234567890123456"
    case .Very_Long_Name: return "long"
    case .Grow:           return "grow"
    }
}
