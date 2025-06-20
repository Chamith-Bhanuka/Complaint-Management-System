package lk.ijse.CMS.model;

import lombok.*;

import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Complaint {
    private int id;
    private int userId;
    private String title;
    private String description;
    private String status;
    private String remarks;
    private Timestamp createdAt;
}
