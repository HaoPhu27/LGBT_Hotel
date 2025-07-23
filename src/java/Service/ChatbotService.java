package Service;

import com.google.genai.Client;
import com.google.genai.types.GenerateContentResponse;
import dao.RoomDAO;
import java.sql.SQLException;
import model.Rooms;
import java.util.List;

public class ChatbotService {

    private final String modelId = "gemini-2.5-flash";
    private final String apiKey = "AIzaSyCrfuRIg4IOmg4XhISin4Jnm0gHkWOGGhQ";

    private final RoomDAO roomDAO = new RoomDAO(); // Gọi DAO

    public ChatbotService() {
    }

    public String chatWithGemini(String userMessage) throws SQLException {

        StringBuilder context = new StringBuilder("Danh sách các loại phòng hiện có:\n\n");
        List<Rooms> rooms = roomDAO.getAllRooms(); 

        for (Rooms r : rooms) {
            context.append("• Tên phòng: ").append(r.getRoomNumber()).append("\n")
                   .append("  • Mô tả: ").append(r.getNote()).append("\n")
                   .append("  • Giá: ").append(r.getPrice()).append(" VND/đêm\n\n");
        }

        String prompt = """
Bạn là nhân viên lễ tân khách sạn. Trả lời bằng tiếng Việt, ngắn gọn, dễ hiểu.

Yêu cầu:
- Trả lời bằng cách gạch đầu dòng rõ ràng (dùng dấu • hoặc -)
- Nếu nói về loại phòng, hãy trình bày rõ ràng từng loại như sau:
  • Tên phòng: ...
  • Mô tả: ...
  • Giá: ...
- Nếu nói về dịch vụ, trình bày từng dịch vụ như:
  • Dịch vụ A: mô tả
  • Dịch vụ B: mô tả
- Không cần đưa hình ảnh.
- Nếu không biết thì trả lời lịch sự, ngắn gọn.

""" + context.toString() + "\nCâu hỏi của khách:\n" + userMessage;

        try (Client client = (apiKey == null || apiKey.isEmpty())
                ? new Client()
                : Client.builder().apiKey(apiKey).build()) {

            GenerateContentResponse response = client.models.generateContent(
                    modelId,
                    prompt,
                    null);

            String rawResult = response.text();
            if (rawResult == null || rawResult.trim().isEmpty()) {
                return "Xin lỗi, tôi chưa có câu trả lời phù hợp.";
            }
            return rawResult;
        } catch (Exception e) {
            e.printStackTrace();
            return "Xin lỗi, hiện tại tôi không thể xử lý yêu cầu của bạn.";
        }
    }
}
