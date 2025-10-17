package org.example.dto;

import org.example.entities.enums.AvailabilityStatus;

import java.time.DayOfWeek;
import java.time.LocalTime;

public class SlotRow {
    private final Long availabilityId;
    private final DayOfWeek day;
    private final LocalTime start;
    private final LocalTime end;
    private final AvailabilityStatus status;

    public SlotRow(Long availabilityId, DayOfWeek day, LocalTime start, LocalTime end, AvailabilityStatus status) {
        this.availabilityId = availabilityId;
        this.day = day;
        this.start = start;
        this.end = end;
        this.status = status;
    }

    public Long getAvailabilityId() {
        return availabilityId;
    }

    public DayOfWeek getDay() {
        return day;
    }

    public LocalTime getStart() {
        return start;
    }

    public LocalTime getEnd() {
        return end;
    }
    public AvailabilityStatus getStatus() { return status; }
}