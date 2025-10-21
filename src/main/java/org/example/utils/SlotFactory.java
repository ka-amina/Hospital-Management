package org.example.utils;

import org.example.entities.Availability;
import org.example.entities.Doctor;
import org.example.entities.enums.AvailabilityStatus;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;

public final class SlotFactory {

    private static final LocalTime START_WORK = LocalTime.of(8, 0);
    private static final LocalTime END_WORK = LocalTime.of(18, 0);
    private static final LocalTime START_LUNCH = LocalTime.of(13, 0);
    private static final LocalTime END_LUNCH = LocalTime.of(14, 0);

    private static final int SLOT_MINUTES = 30;
    private static final int BUFFER_MINUTES = 5;  // 5 min buffer between appointments

    private SlotFactory() {
    }


    public static List<Availability> generate(Doctor doctor,
                                              DayOfWeek day,
                                              List<LocalTime[]> occupiedTimes, LocalDate startDate, LocalDate endDate) {

        List<Availability> slots = new ArrayList<>();

        LocalTime cursor = START_WORK;

        while (cursor.plusMinutes(SLOT_MINUTES).isBefore(END_WORK) ||
                cursor.plusMinutes(SLOT_MINUTES).equals(END_WORK)) {

            LocalTime slotEnd = cursor.plusMinutes(SLOT_MINUTES);

            // skip lunch
            if (!cursor.isBefore(START_LUNCH) && cursor.isBefore(END_LUNCH)) {
                cursor = END_LUNCH;
                continue;
            }
            if (!slotEnd.isBefore(START_LUNCH) && cursor.isBefore(END_LUNCH)) {
                cursor = END_LUNCH;
                continue;
            }

            if (overlaps(cursor, slotEnd, occupiedTimes)) {
                cursor = cursor.plusMinutes(SLOT_MINUTES + BUFFER_MINUTES);
                continue;
            }

            Availability av = new Availability(
                    doctor,
                    day,
                    cursor,
                    slotEnd,
                    AvailabilityStatus.AVAILABLE
            );

            av.setStartDate(startDate);
            av.setEndDate(endDate);
            slots.add(av);

            cursor = cursor.plusMinutes(SLOT_MINUTES + BUFFER_MINUTES);
        }
        return slots;
    }

    private static boolean overlaps(LocalTime start, LocalTime end,
                                    List<LocalTime[]> occupied) {
        for (LocalTime[] range : occupied) {
            LocalTime os = range[0];
            LocalTime oe = range[1];
            if (!(end.isBefore(os) || start.isAfter(oe))) {
                return true;
            }
        }
        return false;
    }
}