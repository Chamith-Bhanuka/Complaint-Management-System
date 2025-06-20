package lk.ijse.CMS.model;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private String role;
}
