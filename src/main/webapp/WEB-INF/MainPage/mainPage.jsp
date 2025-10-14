<%-- 
    Document   : mainPage
    Created on : Oct 1, 2025, 12:54:11 PM
    Author     : Ho Gia Bao - CE191304
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String ctx = request.getContextPath();%>

      <!-- mainPage.jsp -->
<jsp:include page="/WEB-INF/Include/header.jsp" />



        <!-- Hero Carousel -->
        <div id="heroCarousel" class="carousel slide my-4 container" data-bs-ride="carousel" data-bs-interval="5000">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="${pageContext.request.contextPath}/Asset/img1.jpg" class="d-block w-100 img-fluid rounded" alt="Hospital Image 1">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/Asset/img2.jpg" class="d-block w-100 img-fluid rounded" alt="Hospital Image 2">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/Asset/img3.jpg" class="d-block w-100 img-fluid rounded" alt="Hospital Image 3">
                </div>
            </div>

            <!-- Carousel controls -->
            <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>



        <!-- Intro -->
        <div class="container text-center my-4">
            <h1>Nơi chăm sóc sức khỏe trọn vẹn cho bạn.</h1>
        </div>
        <!-- Features Section -->
        <div class="container my-5">
            <div class="row g-4 text-center">

                <!-- Card 1 -->
                <div class="col-md-6 col-lg-3">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h3 class="card-title mb-3">👨‍⚕️ Chuyên gia hàng đầu</h3>
                            <p class="card-text text-muted">
                                FMec quy tụ đội ngũ bác sĩ hàng đầu, không chỉ giỏi chuyên môn mà còn có nhiều năm kinh nghiệm
                                thực tiễn trong lĩnh vực y tế. Mỗi bác sĩ đều được đào tạo bài bản, thường xuyên tham gia các
                                khóa bồi dưỡng và hội thảo quốc tế để luôn cập nhật kiến thức mới, mang đến sự an tâm tuyệt đối
                                cho khách hàng trong quá trình thăm khám và điều trị.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Card 2 -->
                <div class="col-md-6 col-lg-3">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h3 class="card-title mb-3">🌍 Chất lượng quốc tế</h3>
                            <p class="card-text text-muted">
                                Với tiêu chuẩn y tế quốc tế, FMec cam kết mang lại dịch vụ chăm sóc sức khỏe toàn diện, an toàn
                                và chuyên nghiệp. Chúng tôi không chỉ chú trọng kết quả điều trị mà còn đề cao trải nghiệm của
                                bệnh nhân, từ khâu tiếp nhận đến theo dõi sau điều trị, tất cả được thực hiện tận tâm và chu đáo.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Card 3 -->
                <div class="col-md-6 col-lg-3">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h3 class="card-title mb-3">⚙️ Công nghệ tiên tiến</h3>
                            <p class="card-text text-muted">
                                FMec luôn đi đầu trong việc ứng dụng các máy móc, thiết bị hiện đại vào chẩn đoán và điều trị.
                                Hệ thống công nghệ tiên tiến giúp nâng cao độ chính xác, rút ngắn thời gian thăm khám, mang lại
                                hiệu quả cao trong điều trị và phát hiện sớm các bệnh lý.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Card 4 -->
                <div class="col-md-6 col-lg-3">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h3 class="card-title mb-3">🔬 Nghiên cứu đổi mới</h3>
                            <p class="card-text text-muted">
                                Không ngừng nghiên cứu, cập nhật và áp dụng những phương pháp y học mới, FMec luôn hướng đến
                                việc nâng cao chất lượng điều trị. Chúng tôi hợp tác với các tổ chức trong và ngoài nước để phát
                                triển các giải pháp y tế tiên tiến, mang đến lựa chọn an toàn, hiệu quả và phù hợp nhất.
                            </p>
                        </div>
                    </div>
                </div>

            </div>
        </div>


        <!-- Feedback -->
        
        <!-- Footer -->
       <jsp:include page="/WEB-INF/Include/footer.jsp" />


